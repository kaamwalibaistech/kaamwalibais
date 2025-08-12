import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kaamwaalibais/providers/reviewpage_provider.dart';
import 'package:kaamwaalibais/single_pages/review_page.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:provider/provider.dart';

import '../models/how_works_model.dart';

class HowWorksPage extends StatefulWidget {
  const HowWorksPage({super.key});

  @override
  State<HowWorksPage> createState() => _HowWorksPageState();
}

class _HowWorksPageState extends State<HowWorksPage> {
  late ReviewpageProvider reviewPage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reviewPage = Provider.of<ReviewpageProvider>(context, listen: false);
    reviewPage.getReviewData();
  }

  List<HowItWorksModel>? howItWorksList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final s = await howWorksApi();
    setState(() {
      howItWorksList = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("How it Works"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
        ),
      ),
      body:
          howItWorksList == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: Colors.amber, width: 8),
                        ),
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: howItWorksList?.length ?? 0,
                          itemBuilder:
                              (context, index) => Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      border: Border.all(
                                        width: 10,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        howItWorksList?[index].id.toString() ??
                                            "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.grey.shade700,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Html(
                                      data:
                                          howItWorksList?[index].description
                                              .toString() ??
                                          "Error while loading api data.",
                                    ),
                                  ),
                                ],
                              ),
                        ),
                      ),
                      _reviewsSection(),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _reviewsSection() => Consumer<ReviewpageProvider>(
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
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(
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
            Text(
              "WHAT OUR CLIENTS SAY",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 20),
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

                      SizedBox(height: 12),
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
}
