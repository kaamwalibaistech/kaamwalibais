import 'package:flutter/material.dart';

import '../utils/snackbar.dart';

class OurMaidDetailsScreen extends StatelessWidget {
  const OurMaidDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Maid Profile"),
        foregroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'lib/assets/cook.jpeg',
              ), // Replace with your asset
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Center(
                        child: Text(
                          "Ashadevi Yadav",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Address: Near Shankar mandir, Room no. 17, Pathan Wadi, Aarey Road Al. Aman Chawl, Powai, Nitie S.O, Mumbai",
                      ),
                      SizedBox(height: 6),
                      Text("Age: 52"),
                      Text("Status: Married"),
                      Text("Religion: Hindu"),
                      Text("Experience: 20 yrs"),
                      Text("Speaks: Hindi"),
                      Text("Documents: adhar_card  pan_card"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.yellow[700],
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.cleaning_services,
                            size: 40,
                            color: Colors.purple,
                          ),
                          Icon(
                            Icons.child_care,
                            size: 40,
                            color: Colors.purple,
                          ),
                          Icon(Icons.restaurant, size: 40),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "HOUSE MAID",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text("● Clothes Ironing"),
                          SizedBox(height: 12),
                          Text(
                            "BABY SITTER / NANNY",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text("● Baby Massage"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed:
                      () => successToast(
                        context,
                        "Your request has been sent to us, an executive will be contact you soon!",
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text(
                    "HIRE ME",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
