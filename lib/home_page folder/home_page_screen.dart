import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(
      "https://youtu.be/olDOicf6xIM?si=M3oh9W-j-hKgI6sF",
    );
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: YoutubePlayerFlags(autoPlay: false, hideThumbnail: true),
    );
    log(videoId.toString());
  }

  List<Map> logo = [
    {"logo": "lib/assets/twitter.png", "url": ""},
    {"logo": "lib/assets/facebook.png", "url": ""},
    {"logo": "lib/assets/linkedin.png", "url": ""},
    {"logo": "lib/assets/youtube.png", "url": ""},
  ];

  List<Map<String, String>> services = [
    {"image": "lib/assets/maid.jpg", "name": "Maid"},
    {"image": "lib/assets/babysitter.jpeg", "name": "Babysitter"},
    {"image": "lib/assets/cook.jpeg", "name": "Cook"},
    {"image": "lib/assets/eldercare.jpeg", "name": "Elder Care"},
    {"image": "lib/assets/patientcare.jpg", "name": "Patient Care"},
    {"image": "lib/assets/japamaid.jpeg", "name": "Japa Maids"},
    {"image": "lib/assets/petcare.jpeg", "name": "Pet Care"},
    {"image": "lib/assets/driver.jpeg", "name": "Driver"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Image.asset("lib/assets/whatsapp.png", height: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.18,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 221, 221),
                ),
                child: Center(child: Text("Image Data")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text("OUR SERIVCES", style: TextStyle(fontSize: 20)),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: Image.asset(
                            services[index]["image"] ?? "lib/assets/test.jpg",
                            width: 180,
                            height: 200,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            services[index]["name"] ?? "Image Data",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("HOW IT WORKS", style: TextStyle(fontSize: 20)),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "lib/assets/kwbmaid.jpeg",
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("VIDEO", style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 2,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    logo
                        .map(
                          (logo) => Padding(
                            padding: const EdgeInsets.only(
                              right: 8,
                              top: 10,
                              bottom: 30,
                            ),
                            child: Image.asset(logo['logo'], height: 40),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
