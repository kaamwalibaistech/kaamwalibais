import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/ourmiad_folder/our_maid_details_screen.dart';

import '../utils/snackbar.dart';

class OurMaidsScreen extends StatelessWidget {
  const OurMaidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, result) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationScreen(destinations: 0),
            ),
          ),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.primary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed:
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(destinations: 0),
                  ),
                ),
          ),
          title: Text(
            "Our Maids",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: 100,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OurMaidDetailsScreen(),
                  ),
                );
              },
              child: Container(
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
                              onPressed:
                                  () => successToast(
                                    context,
                                    "Your request has been sent to us, an executive will be contact you soon!",
                                  ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
