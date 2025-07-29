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
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("Our Maids", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "lib/assets/test.jpg",
                    width: 150,
                    // height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ashadevi Yadav",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Powai Mumbai, Mumbai",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "52 | Female",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      SizedBox(height: 6),
                      Wrap(
                        spacing: 6,
                        runSpacing: -8,
                        children: [
                          Chip(
                            label: Text("Housemaid"),
                            backgroundColor: Colors.deepPurple[50],
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          onPressed: () {},
                          child: Text(
                            'HIRE ME',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    // >>>>>>> 19a109dae15fa07f04f297b7688c1762783c2f08
  }
}
