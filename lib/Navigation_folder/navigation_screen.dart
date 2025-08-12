import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kaamwaalibais/bookmaid_folder/bookmaid_screen.dart';
import 'package:kaamwaalibais/home_page%20folder/home_page_screen.dart';
import 'package:kaamwaalibais/login_signup_folder/login_landing_screen.dart';
import 'package:kaamwaalibais/ourmiad_folder/our_maids_screen.dart';
import 'package:kaamwaalibais/profile_folder/profile_page.dart';
import 'package:kaamwaalibais/single_pages/how_works_page.dart';
import 'package:kaamwaalibais/single_pages/privacy_policy.dart';
import 'package:kaamwaalibais/single_pages/review_page.dart';
import 'package:kaamwaalibais/single_pages/term_condtion.dart';
import 'package:kaamwaalibais/single_pages/what_we_offer.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationScreen extends StatefulWidget {
  final int destinations;
  const NavigationScreen({super.key, this.destinations = 0});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool? isLoggedin;
  List<Widget> navigationList = [];
  bool isLoading = true;

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
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
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
  void initState() {
    super.initState();
    index = widget.destinations;
    _loadLoginState();
  }

  void _loadLoginState() async {
    await LocalStoragePref.instance?.initPrefBox(); // Ensure initialized
    final loggedIn = LocalStoragePref.instance?.getLoginBool() ?? false;
    setState(() {
      isLoggedin = loggedIn;
      navigationList = [
        MyHomePage(),
        isLoggedin! ? BookmaidScreen() : LoginLandingScreen(),
        isLoggedin! ? OurMaidsScreen() : LoginLandingScreen(),
        isLoggedin! ? ProfileScreen() : LoginLandingScreen(),
      ];
      isLoading = false;
    });
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void shareApp() {
    const url =
        'https://play.google.com/store/apps/details?id=com.innowrap.user.kaamwalibais&pcampaignid=web_share';
    try {
      Share.share(
        '$url\n\nExperience live news, Latest articles, and more — all in one app!',
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || navigationList.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => _onWillPop(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          currentIndex: index,
          onTap: onTapChange,
          type: BottomNavigationBarType.fixed,
          items: const [
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
                  title: const Text(
                    "Kaamwalibais",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    // <<<<<<< ritesh
                    //                     Image.asset("lib/assets/whatsapp.png", height: 35),
                    // =======
                    IconButton(
                      onPressed:
                          () => _launchUrl("https://wa.me/+919819221144"),
                      icon: Image.asset("lib/assets/whatsapp.png", height: 35),
                    ),
                    // >>>>>>> main
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
                  shape: const Border(bottom: BorderSide.none),
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
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 25,
                          bottom: 5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
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
                              _visiPage(index);
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
                              const Divider(),
                              TextButton.icon(
                                // <<<<<<< ritesh
                                //                                 onPressed: () {},
                                //                                 label: const Text(
                                // =======
                                onPressed: () => shareApp(),
                                label: Text(
                                  // >>>>>>> main
                                  "Share",
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: const Icon(Icons.share),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                label: const Text(
                                  "Sign Out",
                                  style: TextStyle(fontSize: 16),
                                ),
                                icon: const Icon(Icons.logout),
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
    "Book maid",
    "What we offer",
    "How it works",
    "About us",
    "Reviews",
    "Contact us",
    "Term & conditions",
    "Privacy Policy",
  ];

  void _visiPage(int index) {
    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:
        // <<<<<<< ritesh
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => BookmaidScreen()),
        //         );
        // =======
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookmaidScreen()),
          );
        }
        break;
      case 2:
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WhatWeOffer()),
          );
        }
        break;
      case 3:
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HowWorksPage()),
          );
        }
        break;
      case 4:
        {}
        // >>>>>>> main
        break;
      case 5:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReviewPage()),
        );
        break;
      case 6:
        {
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermConditionPage()),
            );
          }
        }
        break;
      case 7:
        {
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TermConditionPage()),
            );
          }
        }
        break;
      case 8:
        {
          {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PrivacyPolicy()),
            );
          }
        }
        break;

      default:
        break;
    }
  }
}
