import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/models/sign_up_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupOtpVerificationScreen extends StatefulWidget {
  final String otp;
  final SignupModel? userData;
  const SignupOtpVerificationScreen({
    super.key,
    required this.otp,
    required this.userData,
  });

  @override
  State<SignupOtpVerificationScreen> createState() =>
      _SignupOtpVerificationScreenState();
}

class _SignupOtpVerificationScreenState
    extends State<SignupOtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  int secondsRemaining = 60;
  Timer? timer;
  String? pinCodeText;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining > 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    // Remove controller from widget to avoid late calls
    // // otpController.clear();
    // otpController.removeListener(() {}); // ensure no listeners
    // otpController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneNo = widget.userData?.data["user"]["mobileno"] ?? "";
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        children: [
          const SizedBox(height: 80),
          Image.asset('lib/assets/kaamwalibais.png', height: 80),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Enter verification code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Enter the 4-digit verification code we sent to your number $phoneNo",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),

                  // OTP Text Fields
                  PinCodeTextField(
                    appContext: context,
                    length: 4,
                    controller: otpController,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      inactiveColor: Colors.grey.shade300,
                      activeColor: Colors.blue,
                      selectedColor: Colors.blue,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        pinCodeText = value;
                      });
                    },
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Resend Otp",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      secondsRemaining != 0
                          ? Text(
                            "$secondsRemaining s",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          )
                          : InkWell(
                            onTap: () {
                              setState(() {
                                secondsRemaining = 30;
                                startTimer();
                              });
                            },
                            child: const Text(
                              "Click here",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.green,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      if (pinCodeText == widget.otp) {
                        int? status = await otpVarifyApi(
                          widget.otp,
                          widget.userData?.data["user"]["id"] ?? "",
                          context,
                        );
                        if (status != null || status == 201) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavigationScreen(),
                            ),
                          );
                        }
                        LocalStoragePref.instance?.storeLoginModel(
                          widget.userData!.data,
                        );
                        LocalStoragePref.instance?.setLoginBool(true);
                        log(
                          LocalStoragePref.instance
                                  ?.getLoginBool()
                                  .toString() ??
                              "null",
                        );

                        //   // ScaffoldMessenger.of(
                        //   //   context,
                        //   // ).showSnackBar(SnackBar(content: Text("Success")));
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text("not Success")));
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
