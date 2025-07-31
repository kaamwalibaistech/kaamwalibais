import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/utils/api_routes.dart';

Future<ReviewModel?> homePageApi() async {
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
