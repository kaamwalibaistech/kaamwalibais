import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

import '../models/aboutus_model.dart';
import 'review_widget.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  AboutUsModel? aboutData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await fetchAboutUs();
    setState(() {
      aboutData = result;
      isLoading = false;
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
        title: Text("About us"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
        ),
      ),
      body:
          aboutData == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height * 0.9,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: Colors.amber, width: 8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quote Box
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.format_quote,
                                    color: Colors.deepPurple,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      aboutData?.quote ?? '',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            _paragraph(aboutData?.pTag ?? ''),
                            _paragraph(aboutData?.pTag1 ?? ''),
                            _paragraph(aboutData?.pTag2 ?? ''),
                            _paragraph(aboutData?.pTag3 ?? ''),

                            _image(aboutData?.image1 ?? ''),

                            _paragraph(aboutData?.pTag4 ?? ''),
                            _paragraph(aboutData?.pTag5 ?? ''),
                            _paragraph(aboutData?.pTag6 ?? ''),

                            // h3 heading
                            const SizedBox(height: 10),
                            Text(
                              aboutData?.h3 ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                                fontSize: 16,
                              ),
                            ),
                            const Divider(),

                            const SizedBox(height: 10),
                            // h2 heading
                            Center(
                              child: Text(
                                aboutData?.h2 ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // 3 images in a row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _smallImage(aboutData?.image2 ?? ''),
                                _smallImage(aboutData?.image3 ?? ''),
                                _smallImage(aboutData?.image4 ?? ''),
                              ],
                            ),

                            const SizedBox(height: 10),
                            _image(aboutData?.image5 ?? ''),

                            _paragraph(aboutData?.pTag7 ?? ''),
                            _paragraph(aboutData?.pTag8 ?? ''),
                            _paragraph(aboutData?.pTag9 ?? ''),
                          ],
                        ),
                      ),
                      reviewsSection(),
                    ],
                  ),
                ),
              ),
    );
  }

  // Paragraph widget
  Widget _paragraph(String? text) {
    if (text == null || text.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: const TextStyle(fontSize: 14, height: 1.4)),
    );
  }

  // Full-width image
  Widget _image(String? url) {
    if (url == null || url.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget:
            (context, url, error) => const Icon(Icons.error, color: Colors.red),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  // Small image for row
  Widget _smallImage(String? url) {
    if (url == null || url.isEmpty) return const SizedBox();
    return CachedNetworkImage(
      imageUrl: url,
      placeholder:
          (context, url) => const SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),
          ),
      errorWidget:
          (context, url, error) => const Icon(Icons.error, color: Colors.red),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    );
  }
}
