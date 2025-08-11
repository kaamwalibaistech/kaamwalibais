import 'package:flutter/material.dart';
import 'package:kaamwaalibais/login_signup_folder/login_screen.dart';

class LoginLandingScreen extends StatefulWidget {
  const LoginLandingScreen({super.key});

  @override
  State<LoginLandingScreen> createState() => _LoginLandingScreenState();
}

class _LoginLandingScreenState extends State<LoginLandingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 280.0),
            child: Image.asset(
              "lib/assets/kaamwalibais.png",
              fit: BoxFit.contain,
              width: 300,
            ),
          ),
          SizedBox(height: 30),
          Center(child: Text("Kaamwalibais", style: TextStyle(fontSize: 22))),
          SizedBox(height: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Please Login >",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
