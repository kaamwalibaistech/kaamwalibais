import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/providers/reviewpage_provider.dart'
    show ReviewpageProvider;
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  late ReviewpageProvider reviewPage;

  @override
  void initState() {
    super.initState();
    reviewPage = Provider.of<ReviewpageProvider>(context, listen: false);
    reviewPage.getReviewData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<ReviewpageProvider>(
        builder: (context, reviewPage, _) {
          if (reviewPage.isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          final reviews = reviewPage.reviewModel?.getTestimonialList ?? [];

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  " WHAT OUR CLIENTS SAY",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              review.name ?? "NA",
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.38,
                              child: EasyStarsRating(
                                readOnly: true,
                                arrangementRadius: 20,
                                emptyColor: Colors.black87,
                                filledColor: Colors.black87,
                                allowHalfRating: true,
                                initialRating:
                                    double.tryParse(review.rating ?? "0.0") ??
                                    0.0,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              review.description ?? "NA",
                              textAlign: TextAlign.justify,
                              style: const TextStyle(fontSize: 15),
                            ),
                            if (index != reviews.length - 1)
                              const Divider(
                                color: Colors.white,
                                indent: 30,
                                endIndent: 30,
                                height: 50,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
