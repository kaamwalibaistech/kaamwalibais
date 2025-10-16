import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/home_model.dart';

import '../utils/api_repo.dart';

class HomepageProvider extends ChangeNotifier {
  bool isloading = true;

  Future<HomeModel?> getHomeData() async {
    HomeModel? homepage = await homePageApi();

    notifyListeners();
    isloading = false;
    return homepage;
  }
}
