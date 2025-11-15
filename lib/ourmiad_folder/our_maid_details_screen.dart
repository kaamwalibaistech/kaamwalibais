import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/maidlist_model.dart';

import '../single_pages/contactus_page.dart';

class OurMaidDetailsScreen extends StatelessWidget {
  final MaidData? data;
  const OurMaidDetailsScreen({super.key, this.data});

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
            CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(
                data?.photo ?? "",
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
                    children: [
                      Center(
                        child: Text(
                          data?.name ?? "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text("Address: ${data?.address ?? ""}"),
                      SizedBox(height: 6),
                      Text("Age:  ${data?.age ?? ""}"),
                      Text("Status:  ${data?.maritalStatus ?? ""}"),
                      Text("Religion:  ${data?.religionName ?? ""}"),
                      Text("Experience:  ${data?.workExperience ?? ""} yrs"),
                      Text("Speaks: Hindi"),
                      Text(
                        "Documents:  ${data?.adharCard ?? "NA"}   ${data?.panCard ?? "NA"}",
                      ),
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
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactUsPage(),
                        ),
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
