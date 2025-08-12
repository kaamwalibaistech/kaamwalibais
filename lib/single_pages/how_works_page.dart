import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

import '../models/how_works.dart';

class HowWorksPage extends StatefulWidget {
  const HowWorksPage({super.key});

  @override
  State<HowWorksPage> createState() => _HowWorksPageState();
}

class _HowWorksPageState extends State<HowWorksPage> {
  HowItWorksModel? howItWorksModel;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final s = await howWorksApi();
    setState(() {
      howItWorksModel = s;
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
          howItWorksModel == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(
                  top: 12,
                  right: 12,
                  left: 12,
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  border: Border.all(color: Colors.amber, width: 8),
                ),
                child: SingleChildScrollView(
                  child: Html(
                    data:
                        howItWorksModel?.description ??
                        "Error while loading api data.",
                  ),
                ),
              ),
    );
  }
}
