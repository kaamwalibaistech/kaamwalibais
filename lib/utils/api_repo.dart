import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/models/aboutus_model.dart';
import 'package:kaamwaalibais/models/home_model.dart';
import 'package:kaamwaalibais/models/how_works_model.dart';
import 'package:kaamwaalibais/models/maidlist_model.dart';
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/utils/api_routes.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

import '../models/whatweare_model.dart';

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
Future<GetUserlogIn?> getUserLogIn(phoneNumber) async {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(data['message'])));
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
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
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
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Exception: $e");
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
