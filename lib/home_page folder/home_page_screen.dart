import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
      flags: YoutubePlayerFlags(autoPlay: false),
    );
    log(videoId.toString());
  }

  // final YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'iLnmTe5Q2Qw',
  //   flags: YoutubePlayerFlags(autoPlay: true, mute: true),
  // );

  @override
  Widget build(BuildContext context) {
    List<String> listviewData = [
      "Home",
      "About us",
      "What we offer",
      "How it works",
      "Book maid",
      "Feedback",
      "Contact us",
      "Term & conditions",
      "Privacy Policy",
    ];
    return Scaffold(
      drawer: Drawer(
        shape: Border(bottom: BorderSide.none),

// <<<<<<< ritesh
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Center(
                  child: Text(
                    "Image Data",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Text(listviewData[index]),
                    ),
                  );
                },
              ),
              Divider(),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.share,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Share", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Log out", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
// =======
//         child: Column(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height * 0.20,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//             ),
//           ],
// >>>>>>> main
        ),
      ),
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          SizedBox(width: 5),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 30, weight: 12),

          ),
        ],
      ),
      body: Center(
        child: Padding(
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
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 224, 221, 221),
                      ),
                      child: Center(child: Text("Image Data")),
                    );
                  },
                ),
                SizedBox(height: 20),

                YoutubePlayerBuilder(
                  player: YoutubePlayer(controller: _controller),
                  builder: (p0, p1) {
                    return Column(children: [p1]);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
