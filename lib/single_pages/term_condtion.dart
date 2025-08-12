import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../utils/api_repo.dart';

class TermConditionPage extends StatefulWidget {
  const TermConditionPage({super.key});

  @override
  State<TermConditionPage> createState() => _TermConditionPageState();
}

class _TermConditionPageState extends State<TermConditionPage> {
  String? data;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final s = await termConditionPageApi();
    setState(() {
      data = s;
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
        title: Text("Privacy Policy"),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
        ),
      ),
      body:
          data == null
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
                  child: Html(data: data ?? "Error while loading api data."),
                ),
              ),
    );
  }
}
