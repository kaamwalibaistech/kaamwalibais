import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/models/aboutus_model.dart';
import 'package:kaamwaalibais/models/home_model.dart';
import 'package:kaamwaalibais/models/how_works_model.dart';
import 'package:kaamwaalibais/models/maidlist_model.dart';
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/models/salary_budget_model.dart';
import 'package:kaamwaalibais/models/sign_up_model.dart';
import 'package:kaamwaalibais/models/super_catogries_model.dart';
import 'package:kaamwaalibais/models/time_slot_moel.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/models/whatweare_model.dart';
import 'package:kaamwaalibais/utils/api_routes.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

Future<ReviewModel> reviewsApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.testimonaList);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ReviewModel.fromJson(data);
    } else {
      throw Exception('Model mapping crashed');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<HomeModel?> homePageApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.homePage);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return HomeModel.fromJson(data);
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

// <<<<<<< ritesh
Future<GetUserlogIn?> getUserLogIn(String phoneNumber) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.login);

    final response = await http.post(
      url,
      body: {'login_mobile_no': phoneNumber},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return GetUserlogIn.fromJson(data);
    } else if (response.statusCode == 500) {
      return null;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}

Future<int?> otpVarifyApi(
  String otp,
  String memberId,
  BuildContext context,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.otpVarify);
    final response = await http.post(
      url,
      body: {'otp': otp, 'member_id': memberId},
    );
    if (response.statusCode == 200) {
      return response.statusCode;
    } else if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      LocalStoragePref().setLoginTocken(data['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blueGrey.shade800,
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  data['message'],
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      String aa = LocalStoragePref().gsetLoginTocken() ?? "null";
      log(aa);
      return response.statusCode;
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}

// =======
Future<WhatweareModel?> whatWeOffer() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.whatWeOffer);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return WhatweareModel.fromJson(data);
      // >>>>>>> main
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

Future<String?> privacyPolicyApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.privacy);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // log(data[0]["description"]);
      return data[0]["description"];
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

Future<String?> termConditionPageApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.term);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // log(data[0]["description"]);
      return data[0]["description"];
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

Future<List<HowItWorksModel>?> howWorksApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.howWorks);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      List<HowItWorksModel> howItWorksList =
          (data).map((item) => HowItWorksModel.fromJson(item)).toList();
      return howItWorksList;
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

Future<AboutUsModel?> fetchAboutUs() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.aboutus);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return AboutUsModel.fromJson(jsonData);
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("Exception: $e");
  }
  return null;
}

Future<MaidlistModel?> maidLists(String token) async {
  try {
    final url = Uri.parse(
      "https://kamwalibais.com/api/maid-details-all?page=2",
    );
    // final url = Uri.parse(ApiRoutes.url + ApiRoutes.maidlists);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return MaidlistModel.fromJson(jsonData);
    } else if (response.statusCode == 201) {
      log("Error: ${response.statusCode}");
      final jsonData = json.decode(response.body);

      return MaidlistModel.fromJson(jsonData);
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("Exception: $e");
  }
  return null;
}

Future<AboutUsModel?> bookMaidForm(
  String selectedMaidFor,
  String locationValue,
  String requirement,
  String selectedGender,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.bookmaid);
    final response = await http.post(
      url,
      // body: {'login_mobile_no': phoneNumber},
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return AboutUsModel.fromJson(jsonData);
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("Exception: $e");
  }
  return null;
}

Future<String?> contactUsApi(
  String name,
  String phone,
  String email,
  String query,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.contactus);
    final body = {
      'contact_name': name,
      'contact_phone': phone,
      'contact_emailid': email,
      'contact_message': query,
    };
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    if (response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      log(jsonData);
      return jsonData['Message'];
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("Exception: $e");
  }
  return null;
}

Future<String?> maidEnquiryMailSendApi(
  String? name,
  String? phone,
  String? email,
  String? location,
  String? requirement,
  String? selectedHours,
  String? gender,
  String? selectedHour,
  String? selectedPrice,
  String? numberOfPeople,
  String? houseSize,
  String? religion,
  String? agePreference,
  String? maidFor,
  String? comments,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.sendMailEnquiry);

    final body = {
      "customer_name": name ?? "",
      "contact_no": phone ?? "",
      "email_id": email ?? "",
      "area": location ?? "",
      "requirement": requirement ?? "",
      "package": selectedHours ?? "",
      "gender_pref": gender ?? "",
      "time_slot": selectedHour ?? "",
      "salary_budget": selectedPrice ?? "",
      "no_of_people": numberOfPeople ?? "",
      "house_type": houseSize ?? "",
      "religion": religion ?? "",
      "age_pref": agePreference ?? "",
      "service": maidFor ?? "",
      "other_comments": comments ?? "",
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode(body),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      log("✅ Success: $jsonData");
      return jsonData["status"];
    } else {
      log("❌ Error: ${response.statusCode} ${response.body}");
    }
  } catch (e) {
    log("⚠️ Exception: $e");
  }
  return null;
}

Future<int?> maidRegistrationFormApi(
  String? name,
  String? city,
  String? area,
  String? address,
  String? language,
  String? phone,
  String? age,
  String? maritalStatus,
  String? gender,
  String? religion,
  String? workExp,
  String? selectedPackage,
  String? timeSlot,
  String? mainService,
  // String? comments,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.maidFormRegister);

    final body = {
      "name": name ?? "",
      "city": city ?? "",
      "area": area ?? "",
      "address": address ?? "",
      "language": language ?? "",
      "phoneno": phone ?? "",
      "age": age ?? "",
      "marital_status": maritalStatus ?? "",
      "gender": gender ?? "",
      "religion_id": religion ?? "",
      "work_experience": workExp ?? "",
      "package_id": selectedPackage ?? "",
      "timeslot_id": timeSlot ?? "",
      "super_cat_id[]": mainService ?? "",
      "cat_id[]": "",
      "sub_cat_id[]": "",
    };

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData["code"];
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("⚠️ Exception: $e");
  }
  return null;
}

Future<TimeslotModel?> timeSlotApi() async {
  try {
    final url = Uri.parse("https://kamwalibais.com/api/timeslots");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return timeslotModelFromJson(response.body);
    }
  } catch (e) {
    print("Exception: $e");
  }
  return null;
}

Future<SuperCategoryModel?> fetchSuperCategories() async {
  try {
    final url = Uri.parse("https://kamwalibais.com/api/get-supercategories");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return SuperCategoryModel.fromJson(jsonData);
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
  }
  return null;
}

Future<PackageModel?> fetchPackages() async {
  try {
    final url = Uri.parse("https://kamwalibais.com/api/get_packages");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return PackageModel.fromJson(jsonData);
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
  }
  return null;
}

Future<SignupModel?> signUpApi(
  String name,
  String mobileNo,
  String emailId,
  String country,
) async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.signUp);
    final response = await http.post(
      url,
      body: {
        'register_name': name,
        'register_mobileno': mobileNo,
        'register_emailid': emailId,
        'register_country': country,
      },
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return SignupModel.fromJson(jsonData);
    } else {
      log("Error: ${response.statusCode}");
    }
  } catch (e) {
    log("Exception: $e");
  }
  return null;
}
