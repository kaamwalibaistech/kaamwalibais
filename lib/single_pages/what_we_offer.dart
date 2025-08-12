import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/whatweare_model.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/api_repo.dart';
import 'services_item.dart';

class WhatWeOffer extends StatefulWidget {
  const WhatWeOffer({super.key});

  @override
  State<WhatWeOffer> createState() => _WhatWeOfferState();
}

class _WhatWeOfferState extends State<WhatWeOffer> {
  WhatweareModel? whatweareModel;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final data = await whatWeOffer();
    setState(() {
      whatweareModel = data;
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
          color: Colors.deepPurpleAccent.shade100.withAlpha(50),
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
        title: Text("What we offer"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
        ),
      ),
      body:
          whatweareModel == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(color: Colors.amber, width: 8),
                  ),
                  child: ListView.builder(
                    itemCount: getServiceList(whatweareModel!).length,
                    itemBuilder: (context, index) {
                      final service = getServiceList(whatweareModel!)[index];
                      log(service.image.toString());
                      return Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: service.image.trim(),
                            width: 180,
                            height: 200,
                            fit: BoxFit.fitHeight,
                            placeholder: (context, url) => shimmer(),
                            errorWidget:
                                (context, url, error) => Icon(Icons.error),
                          ),

                          SizedBox(height: 30),
                          RichText(
                            text: TextSpan(
                              text: service.title,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: "\n\n${service.content}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 30),
                        ],
                      );
                    },
                  ),
                ),
              ),
    );
  }
}
