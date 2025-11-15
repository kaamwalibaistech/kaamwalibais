import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kaamwaalibais/providers/reviewpage_provider.dart';
import 'package:kaamwaalibais/single_pages/review_page.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:provider/provider.dart';

import '../models/how_works_model.dart';
import 'review_widget.dart';

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
                      reviewsSection(),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
    );
  }
}
