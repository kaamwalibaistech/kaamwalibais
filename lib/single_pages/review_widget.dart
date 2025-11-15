import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/providers/reviewpage_provider.dart';
import 'package:kaamwaalibais/single_pages/review_page.dart';
import 'package:provider/provider.dart';

Widget reviewsSection({bool isHomePage = false}) =>
    Consumer<ReviewpageProvider>(
      builder: (context, reviewPage, _) {
        if (reviewPage.isloading) {
          return Container(
            // width: double.infinity,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.amber.shade200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          );
        }

        final reviews = reviewPage.reviewModel?.getTestimonialList ?? [];

        return Container(
          // width: double.infinity,
          padding:
              isHomePage
                  ? EdgeInsets.only(top: 23, right: 10, left: 10)
                  : EdgeInsets.all(20),
          margin:
              isHomePage
                  ? null
                  : EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                  ),
          decoration: BoxDecoration(
            color: Colors.amber.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              if (isHomePage == false)
                Text(
                  "WHAT OUR CLIENTS SAY",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.grey.shade700,
                  ),
                ),
              if (isHomePage == false) SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: reviews.length,
                itemBuilder:
                    (context, index, realIndex) => Column(
                      children: [
                        Text(
                          reviews[index].name ?? "NA",
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
                              reviews[index].rating ?? "NA",
                            ),
                          ),
                        ),

                        // SizedBox(height: 12),
                        Text(
                          reviews[index].description ?? "NA",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton(
                          onPressed:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReviewPage(),
                                ),
                              ),
                          child: Text(
                            "read more",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.2,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  autoPlayCurve: Curves.easeInOut,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enableInfiniteScroll: true,
                  padEnds: true,
                ),
              ),
            ],
          ),
        );
      },
    );
