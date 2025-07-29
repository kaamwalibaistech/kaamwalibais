import 'package:flutter/material.dart';

class OurMaidsScreen extends StatelessWidget {
  const OurMaidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // <<<<<<< HEAD
    //     return const Scaffold(body: Center(child: Text("Our Maids Screen")));
    // =======
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
    // >>>>>>> 19a109dae15fa07f04f297b7688c1762783c2f08
  }
}
