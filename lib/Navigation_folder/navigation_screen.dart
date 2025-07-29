import 'package:flutter/material.dart';
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
    MyHomePage(title: "Kaamwalibais"),
    BookmaidScreen(),
    OurMaidsScreen(),
    ProfileScreen(),
  ];
  int index = 0;
  void onTapChange(int value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
