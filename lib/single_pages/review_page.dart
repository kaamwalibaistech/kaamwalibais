import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/review_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageSate();
}

class _ReviewPageSate extends State<ReviewPage> {
  ReviewModel? reviewModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    final apicall = await homePageApi();
    setState(() {
      reviewModel = apicall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Reviews", style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              " WHAT OUR CLIENTS SAY",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  itemCount: reviewModel?.getTestimonialList?.length ?? 0,
                  itemBuilder:
                      (context, index) => Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            reviewModel?.getTestimonialList?[index].name ??
                                "NA",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.38,

                            child: EasyStarsRating(
                              readOnly: true,
                              arrangementRadius: 20,
                              emptyColor: Colors.black87,
                              filledColor: Colors.black87,
                              allowHalfRating: true,
                              initialRating: double.parse(
                                reviewModel
                                        ?.getTestimonialList?[index]
                                        .rating ??
                                    "0",
                              ),
                            ),
                          ),

                          SizedBox(height: 15),
                          Text(
                            reviewModel
                                    ?.getTestimonialList?[index]
                                    .description ??
                                "NA",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 15),
                          ),
                          // SizedBox(height: 10),
                          if (index !=
                              reviewModel!.getTestimonialList!.length - 1)
                            Divider(
                              color: Colors.white,
                              indent: 30,
                              endIndent: 30,
                              height: 50,
                            ),
                        ],
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
