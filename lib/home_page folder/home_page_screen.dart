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
  bool _videoError = false;

  @override
  void initState() {
    super.initState();
    getReady();
    checkForUpdate();

    // Initialize with safe default video
    _controller = YoutubePlayerController(
      initialVideoId: "olDOicf6xIM",
      flags: const YoutubePlayerFlags(autoPlay: false, hideThumbnail: true),
    );
  }

  getReady() async {
    try {
      homePro = Provider.of<HomepageProvider>(context, listen: false);
      final apicall = await homePro.getHomeData();
      if (!mounted) return;

      setState(() {
        homeModel = apicall;
        final rawVideoUrl = homeModel?.getVideoUrl?.toString() ?? "";
        String? videoId = YoutubePlayer.convertUrlToId(rawVideoUrl);

        // handle invalid or numeric video IDs
        if (videoId == null ||
            videoId.isEmpty ||
            int.tryParse(videoId) != null) {
          _videoError = true;
          videoId = "olDOicf6xIM";
        } else {
          _videoError = false;
        }

        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(autoPlay: false, hideThumbnail: true),
        );
      });
    } catch (e) {
      debugPrint("Error loading video: $e");
      setState(() {
        _videoError = true;
      });
    }
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return homePro.isloading == true
        ? shimmerHomeScreen()
        : YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.redAccent,
            onReady: () {
              debugPrint('YouTube player ready.');
            },
            // 👇 Hide the actual video player if error
            bottomActions: _videoError ? [] : null,
          ),

          builder: (context, player) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => _launchUrl("https://wa.me/+919819221144"),
                child: Image.asset("lib/assets/whatsapp.png", height: 40),
              ),
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          _headerSection(isTablet),
                          _servicesSection(isTablet),
                          _howItWorksSection(isTablet),
                          reviewsSection(isHomePage: true),
                          _videoSection(player, isTablet),
                          const SizedBox(height: 10),
                          _socialSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _headerSection(bool isTablet) => ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(
      imageUrl:
          // homeModel?.getSliderList?[0].photo ??
          "https://kamwalibais.com/admin/images/slider/slider-11526456763.jpg",
      fit: BoxFit.cover,
      width: double.infinity,
      height: isTablet ? 350 : 250,
      placeholder:
          (context, url) => Container(
            height: isTablet ? 350 : 250,
            width: double.infinity,
            color: Colors.deepPurpleAccent.shade100.withAlpha(50),
          ),
    ),
  );

  Widget _servicesSection(bool isTablet) {
    final crossAxisCount = isTablet ? 4 : 2;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text(
            "OUR SERVICES",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: isTablet ? 0.8 : 0.75,
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
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                          child: Image.asset(
                            services[index]["image"] ?? "",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          services[index]["name"] ?? "",
                          style: TextStyle(
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ),
      ],
    );
  }

  Widget _howItWorksSection(bool isTablet) => Column(
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("HOW IT WORKS", style: TextStyle(fontSize: 20)),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "lib/assets/kwbmaid.jpeg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: isTablet ? 400 : 250,
        ),
      ),
    ],
  );

  Widget _videoSection(Widget player, bool isTablet) => Column(
    children: [
      const SizedBox(height: 25),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("VIDEO", style: TextStyle(fontSize: 20)),
      ),
      SizedBox(
        height: isTablet ? 400 : 220,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child:
              _videoError
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.error_outline, color: Colors.red, size: 40),
                      SizedBox(height: 8),
                      Text(
                        "Video not available",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  )
                  : (homeModel == null
                      ? const Center(child: CircularProgressIndicator())
                      : player),
        ),
      ),
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
