import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: Border(bottom: BorderSide.none),

        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
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
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.18,

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 221, 221),
                ),
                child: Center(child: Text("Image")),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text("OUR SERIVCES", style: TextStyle(fontSize: 20)),
              ),
              // GridView.builder(
              //   shrinkWrap: true,
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //   ),
              //   itemBuilder:
              //       (BuildContext, context) => Container(
              //         height: 10,
              //         width: 10,
              //         decoration: BoxDecoration(color: Colors.black),
              //       ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
