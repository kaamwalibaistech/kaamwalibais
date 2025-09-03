import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaamwaalibais/login_signup_folder/otp_signup_screen.dart';
import 'package:kaamwaalibais/models/sign_up_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupModel? data;

  // Create controllers
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final countryController = TextEditingController(text: "India");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.asset('lib/assets/kaamwalibais.png', height: 150),
            ),
            const SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.72,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: 'Enter Your Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Enter Mobile Number',
                    controller: mobileController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'Enter Your Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hintText: 'India',
                    controller: countryController,
                  ), // You can replace this with a dropdown if needed
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        EasyLoading.show();

                        // Example: Read user inputs

                        // Example: call your API here
                        data = await signUpApi(
                          nameController.text,
                          mobileController.text,
                          emailController.text,
                          countryController.text,
                        );
                        if (data!.response == 3) {
                          EasyLoading.dismiss();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(data?.msg ?? "")),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SignupOtpVerificationScreen(
                                    otp: data?.data["otp"] ?? "",
                                    userData: data,
                                  ),
                            ),
                          );
                        } else {
                          EasyLoading.dismiss();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(data?.msg ?? "")),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Continue"),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // ✅ fixed: now it stores values
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueGrey),
        ),
      ),
    );
  }
}
