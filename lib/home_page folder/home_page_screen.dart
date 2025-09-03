import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:kaamwaalibais/models/home_model.dart';
import 'package:kaamwaalibais/providers/homepage_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../single_pages/review_widget.dart';
import 'services_details_page.dart';
import 'shimmers/homepage_shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> checkForUpdate() async {
    try {
      AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();

      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateInfo.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (updateInfo.flexibleUpdateAllowed) {
          await InAppUpdate.startFlexibleUpdate();
          await InAppUpdate.completeFlexibleUpdate();
        } else {
          print("Update available, but no method allowed.");
        }
      }
    } catch (e) {
      print("Error checking for update: $e");
    }
  }

  late YoutubePlayerController _controller;
  late HomepageProvider homePro;
  HomeModel? homeModel;
  @override
  void initState() {
    super.initState();
    checkForUpdate();
    final videoId = YoutubePlayer.convertUrlToId(
      homeModel?.getVideoUrl ??
          "https://youtu.be/olDOicf6xIM?si=M3oh9W-j-hKgI6sF",
    );
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(autoPlay: false, hideThumbnail: true),
    );

    getReady();
  }

  getReady() async {
    homePro = Provider.of<HomepageProvider>(context, listen: false);
    final apicall = await homePro.getHomeData();
    setState(() {
      homeModel = apicall;
    });
  }

  List<Map> logo = [
    {"logo": "lib/assets/twitter.png", "url": "https://x.com/kaamwalibais"},
    {
      "logo": "lib/assets/facebook.png",
      "url": "https://www.facebook.com/kaamwalibais1/",
    },
    {
      "logo": "lib/assets/linkedin.png",
      "url": "https://www.linkedin.com/in/kaamwalibai-s-ab70377a/",
    },
    {
      "logo": "lib/assets/youtube.png",
      "url": "https://www.youtube.com/@kaamwaliacademy11",
    },
  ];

  List<Map<String, String>> services = [
    {"image": "lib/assets/maid.jpg", "name": "Maids"},
    {"image": "lib/assets/babysitter.jpeg", "name": "Babysitter"},
    {"image": "lib/assets/cook.jpeg", "name": "Cook"},
    {"image": "lib/assets/eldercare.jpeg", "name": "Elder Care"},
    {"image": "lib/assets/patientcare.jpg", "name": "Patient Care"},
    {"image": "lib/assets/japamaid.jpeg", "name": "Japa Maids"},
    {"image": "lib/assets/petcare.jpeg", "name": "Pet Care"},
    {"image": "lib/assets/driver.jpeg", "name": "Driver"},
  ];

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return homePro.isloading == true
        ? shimmerHomeScreen()
        : YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),

          builder: (context, player) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => _launchUrl("https://wa.me/+919819221144"),
                child: Image.asset("lib/assets/whatsapp.png", height: 40),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _headerSection(),
                      _servicesSection(),
                      _howItWorksSection(),
                      reviewsSection(isHomePage: true),
                      _videoSection(player),
                      SizedBox(height: 10),
                      _socialSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _headerSection() => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(
      imageUrl:
          homeModel?.getSliderList?[0].photo ??
          "https://kamwalibais.com/admin/images/slider/slider-11526456763.jpg",
      fit: BoxFit.fill,
      placeholder:
          (context, url) => Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.maxFinite,
            color: Colors.deepPurpleAccent.shade100.withAlpha(50),
          ),
    ),
  );

  Widget _servicesSection() => Column(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Text("OUR SERIVCES", style: TextStyle(fontSize: 20)),
      ),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 15,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        itemCount: services.length,
        itemBuilder:
            (context, index) => GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ServicesDetailsPage(
                            serviceName: services[index]["name"] ?? "maids",
                          ),
                    ),
                  ),
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.asset(
                        services[index]["image"] ?? "",
                        width: 180,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        services[index]["name"] ?? "",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    ],
  );

  Widget _howItWorksSection() => Column(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("HOW IT WORKS", style: TextStyle(fontSize: 20)),
      ),
      Image.asset("lib/assets/kwbmaid.jpeg", fit: BoxFit.cover),
    ],
  );

  Widget _videoSection(Widget player) => Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 25),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("VIDEO", style: TextStyle(fontSize: 20)),
      ),
      ClipRRect(borderRadius: BorderRadius.circular(5), child: player),
    ],
  );

  Widget _socialSection() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:
        logo
            .map(
              (l) => IconButton(
                onPressed: () => _launchUrl(l['url']),
                icon: Image.asset(l['logo'], height: 42),
              ),
            )
            .toList(),
  );
}
