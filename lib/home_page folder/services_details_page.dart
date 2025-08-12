import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/whatweare_model.dart';
import 'package:kaamwaalibais/single_pages/services_item.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/api_repo.dart';

class ServicesDetailsPage extends StatefulWidget {
  final String serviceName;

  const ServicesDetailsPage({super.key, required this.serviceName});

  @override
  State<ServicesDetailsPage> createState() => _ServicesDetailsPageState();
}

class _ServicesDetailsPageState extends State<ServicesDetailsPage> {
  ServiceItem? selectedService;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final data = await whatWeOffer(); // API call
    final list = getServiceList(data!);

    // Find the service by name
    final match = list.firstWhere(
      (item) => item.title.toLowerCase() == widget.serviceName.toLowerCase(),
      orElse: () => ServiceItem(image: '', title: '', content: ''),
    );

    setState(() {
      selectedService = match;
    });
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.deepPurpleAccent.shade100.withAlpha(150),
      highlightColor: Colors.deepPurpleAccent.shade100.withAlpha(50),
      child: Container(
        width: 180,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text("Our Services"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
        ),
      ),
      body:
          selectedService == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.all(22),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.amber, width: 8),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: selectedService!.image,
                          width: 180,
                          height: 200,
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) => shimmer(),
                          errorWidget:
                              (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          text: selectedService!.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "\n\n${selectedService!.content}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
