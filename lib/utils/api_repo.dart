import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/models/home_model.dart';
import 'package:kaamwaalibais/models/how_works.dart';
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/utils/api_routes.dart';

import '../models/whatweare_model.dart';

Future<ReviewModel?> reviewsApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.testimonaList);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ReviewModel.fromJson(data);
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
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
      log(data[0]["description"]);
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
      log(data[0]["description"]);
      return data[0]["description"];
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}

Future<HowItWorksModel?> howWorksApi() async {
  try {
    final url = Uri.parse(ApiRoutes.url + ApiRoutes.howWorks);

    final response = await http.get(url, headers: {});
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return HowItWorksModel.fromJson(data);
    }
  } catch (e) {
    log(e.toString());
  }

  return null;
}
