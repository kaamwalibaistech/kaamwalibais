import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';

import '../models/review_model.dart';
import 'api_repo.dart';

// class ReviewUI {
//   Future<ReviewModel?> getData() async {
//     return
//   }

Future<Widget> buildReviewWidget() async {
  ReviewModel? reviewModel = await reviewsApi();
  return Container(
    // width: double.infinity,
    padding: EdgeInsets.only(top: 23, right: 10, left: 10),
    decoration: BoxDecoration(
      color: Colors.amber.shade200,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
    ),
    child: CarouselSlider.builder(
      itemCount: reviewModel?.getTestimonialList?.length ?? 0,
      itemBuilder:
          (context, index, realIndex) => Column(
            children: [
              Text(
                reviewModel?.getTestimonialList?[index].name ?? "NA",
                style: TextStyle(fontSize: 20),
              ),
              // SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.36,

                child: EasyStarsRating(
                  readOnly: true,
                  arrangementRadius: 20,
                  emptyColor: Colors.black87,
                  filledColor: Colors.black87,
                  allowHalfRating: true,
                  initialRating: double.parse(
                    reviewModel?.getTestimonialList?[index].rating ?? "NA",
                  ),
                ),
              ),

              SizedBox(height: 12),
              Text(
                reviewModel?.getTestimonialList?[index].description ?? "NA",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              TextButton(
                onPressed: () {},
                child: Text("read more", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
      options: CarouselOptions(
        // height: MediaQuery.of(context).size.height * 0.22,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1,
        autoPlayCurve: Curves.easeInOut,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        enableInfiniteScroll: true,
        padEnds: true,
      ),
    ),
  );
}

// }
