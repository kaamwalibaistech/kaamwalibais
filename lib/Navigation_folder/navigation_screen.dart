import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaamwaalibais/bookmaid_folder/bookmaid_screen.dart';
import 'package:kaamwaalibais/home_page%20folder/home_page_screen.dart';
import 'package:kaamwaalibais/ourmiad_folder/our_maids_screen.dart';
import 'package:kaamwaalibais/profile_folder/profile_page.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Widget> navigationList = [
    MyHomePage(),
    BookmaidScreen(),
    OurMaidsScreen(),
    ProfileScreen(),
  ];
  int index = 0;
  int navigationSelectedInx = 0;
  Future<bool> _onWillPop() async {
    return await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text("Confirm Exit"),
                content: const Text("Do you really want to exit the app?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false), // Cancel
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true), // Exit
                    child: const Text("Exit"),
                  ),
                ],
              ),
        ) ??
        false;
  }

  void onTapChange(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        if (index == 0) {
          final shouldExit = await _onWillPop();
          if (shouldExit) {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          }
        } else {
          setState(() {
            index = 0;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: index,
          onTap: onTapChange,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search_rounded),
              label: "Book Maid",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cleaning_services_sharp),
              label: "Our Maids",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
        body: navigationList[index],
        appBar:
            index == 0
                ? AppBar(
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    "Kaamwalibais",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    Image.asset("lib/assets/whatsapp.png", height: 35),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookmaidScreen(),
                            ),
                          );
                        },
                        icon: Image.asset("lib/assets/search.png", height: 26),
                      ),
                    ),
                  ],
                )
                : null,
        drawer:
            index == 0
                ? Drawer(
                  shape: Border(bottom: BorderSide.none),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Image.asset("lib/assets/kaamwalibais.png"),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 25,
                          bottom: 5,
                        ),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemExtent: 42,
                        itemCount: listviewData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final isSelected = navigationSelectedInx == index;
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                navigationSelectedInx = index;
                              });
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(
                                isSelected
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.primary.withAlpha(200)
                                    : Colors.transparent,
                              ),
                              alignment: Alignment.centerLeft,
                              shape: WidgetStateProperty.all<
                                RoundedRectangleBorder
                              >(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            child: Text(
                              listviewData[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Share",
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: Icon(Icons.share),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                label: Text(
                                  "Sing Out",
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: Icon(Icons.logout),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom,
                      ),
                    ],
                  ),
                )
                : null,
      ),
    );
  }

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
}
