import 'package:flutter/material.dart';

class OurMaidsScreen extends StatelessWidget {
  const OurMaidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("Our Maids"),
      ),
    );
  }
}
