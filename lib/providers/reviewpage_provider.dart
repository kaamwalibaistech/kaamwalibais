import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

class ReviewpageProvider extends ChangeNotifier {
  bool isloading = true;
  ReviewModel? reviewModel;

  Future<void> getReviewData() async {
    isloading = true;
    reviewModel = await reviewsApi();
    isloading = false;
    notifyListeners();
  }
}
