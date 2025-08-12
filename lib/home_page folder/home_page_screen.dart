import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/home_model.dart';
import 'package:kaamwaalibais/providers/homepage_provider.dart';
import 'package:kaamwaalibais/utils/reviews.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'services_details_page.dart';
import 'shimmers/homepage_shimmer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late YoutubePlayerController _controller;
  late HomepageProvider homePro;
  HomeModel? homeModel;
  @override
  void initState() {
    super.initState();
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
    // final apicall = await homePageApi();
    // setState(() {
    //   homeModel = apicall;
    // });
    final apicall = await homePro.getHomeData();
    setState(() {
      homeModel = apicall;
    });
  }

  List<Map> logo = [
    {"logo": "lib/assets/twitter.png", "url": ""},
    {"logo": "lib/assets/facebook.png", "url": ""},
    {"logo": "lib/assets/linkedin.png", "url": ""},
    {"logo": "lib/assets/youtube.png", "url": ""},
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
                // onPressed: () => _launchUrl("https://drive.google.com"),
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
                      _reviewsSection(),
                      _videoSection(player),
                      _socialSection(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }

  Widget _headerSection() => CarouselSlider.builder(
    itemCount: homeModel?.getSliderList?.length ?? 0,
    itemBuilder: (context, index, realIndex) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: homeModel!.getSliderList?[index].photo ?? "",
          fit: BoxFit.fill,
          placeholder:
              (context, url) => Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.maxFinite,
                color: Colors.deepPurpleAccent.shade100,
              ),
        ),
      );
    },
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * 0.25,
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 1,
      autoPlayCurve: Curves.easeInOut,
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      enableInfiniteScroll: true,
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
                            // image: services[index]["image"] ?? "",
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
                        services[index]["image"]!,
                        width: 180,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        services[index]["name"]!,
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
  Widget _reviewsSection() => Container(
    // width: double.infinity,
    padding: EdgeInsets.only(top: 23, right: 10, left: 10),
    decoration: BoxDecoration(
      color: Colors.amber.shade200,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: CarouselSlider.builder(
      itemCount: homeModel?.getTestimonialList?.length ?? 0,
      itemBuilder:
          (context, index, realIndex) => Column(
            children: [
              Text(
                homeModel?.getTestimonialList?[index].name ?? "NA",
                style: TextStyle(fontSize: 20),
              ),
              // SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.36,

                child: EasyStarsRating(
                  readOnly: true,
                  arrangementRadius: 20,
                  emptyColor: Colors.black87,
                  filledColor: Colors.black87,
                  allowHalfRating: true,
                  initialRating: double.parse(
                    homeModel?.getTestimonialList?[index].rating ?? "NA",
                  ),
                ),
              ),

              SizedBox(height: 12),
              Text(
                homeModel?.getTestimonialList?[index].description ?? "NA",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              TextButton(
                onPressed: () {},
                child: Text("read more", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
      options: CarouselOptions(
        // height: MediaQuery.of(context).size.height * 0.22,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayCurve: Curves.easeInOut,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: true,
        padEnds: true,
      ),
    ),
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
              (l) => Padding(
                padding: const EdgeInsets.only(right: 8, top: 10, bottom: 30),
                child: Image.asset(l['logo'], height: 40),
              ),
            )
            .toList(),
  );
}
