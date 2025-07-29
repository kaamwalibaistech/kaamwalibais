import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              padding: EdgeInsets.all(30),
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                // textColor: Colors.white,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
                subtitleTextStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15,
                ),
                title: Text("Test User"),
                subtitle: Text("abc@gmail.com"),
              ),
            ),
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 0,
                color: Colors.white,
                child: Center(
                  child: ListTile(
                    title: Text(
                      "Manage Your Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Card(
                margin: EdgeInsets.all(10),
                elevation: 0,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.logout_rounded),
                    ),
                    Text(
                      "Sign Out",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
