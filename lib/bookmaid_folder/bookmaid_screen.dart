import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/bookmaid_folder/maid_request_form.dart';
import 'package:kaamwaalibais/models/searchlocation_model.dart';
import 'package:location/location.dart' as loc;

class BookmaidScreen extends StatefulWidget {
  const BookmaidScreen({super.key});

  @override
  State<BookmaidScreen> createState() => _BookmaidScreenState();
}

class _BookmaidScreenState extends State<BookmaidScreen> {
  // String? selectedGender;
  SearchLocationModel? searchLocationModel;
  bool isLoading = false;
  TextEditingController locationValue = TextEditingController();
  String? selectedLocationSuggestion;
  List<String> maidForOptions = [
    'HOUSEMAID',
    'BABY SITTER',
    'NANNY',
    'COOKING',
    'CHEF',
    'ELDERLY CARE',
    'PATIENT CARE',
  ];
  List<String> requirementOptions = [
    'Immediately',
    'Not Immediately',
    'Not Sure',
  ];

  String? selectedMaidFor;
  String? selectedRequirement;
  // @override
  // void initState() {
  //   super.initState();
  //   location();
  // }

  Future<SearchLocationModel> getLocation(String searchKey) async {
    log("Log: enableLocation");
    loc.Location location =
        loc.Location(); //explicit reference to the Location class
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
    // searchKey = "Mumbai";
    Uri url = Uri.parse(
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchKey&components=country:in&radius=500&key=AIzaSyCJq_EIK9nmK1SHahnMofcnVkTFIe0U7cA",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return SearchLocationModel.fromJson(data);
      }
    } catch (e) {
      throw Exception();
    }
    return throw Exception();
  }

  // final List<String> cities = [
  //   "Mumbai",
  //   "Delhi",
  //   "Bengaluru",
  //   "Hyderabad",
  //   "Chennai",
  //   "Kolkata",
  //   "Pune",
  //   "Jaipur",
  // ];

  // List<String> filteredCities = [];

  // void _filterCities(String query) {
  //   setState(() {
  //     filteredCities =
  //         cities
  //             .where((city) => city.toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:
          (didPop, result) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NavigationScreen(destinations: 0),
            ),
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Maid"),
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed:
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(destinations: 0),
                  ),
                ),
          ),
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Find Professional Maid",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              TypeAheadField<String>(
                // must return a Future/List
                suggestionsCallback: (pattern) async {
                  if (pattern.isEmpty) return [];
                  try {
                    searchLocationModel = await getLocation(pattern);
                    log(searchLocationModel!.predictions.first.description);
                    return searchLocationModel!.predictions
                        .map((prediction) => prediction.description)
                        .toList();
                  } catch (e) {
                    log(e.toString());
                    return [];
                  }
                },
                // how each suggestion looks
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text(suggestion),
                  );
                },
                // what happens when user taps suggestion
                onSelected: (String suggestion) {
                  setState(() {
                    selectedLocationSuggestion = suggestion;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You selected $suggestion")),
                  );
                },
                // build the search box itself
                builder: (context, controller, focusNode) {
                  if (selectedLocationSuggestion != null) {
                    return TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Selected Location",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      controller: TextEditingController(
                        text: selectedLocationSuggestion,
                      ),
                    );
                  } else {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: "Search Location",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),

              // SizedBox(height: 20),
              Text(
                "I need maid for...",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              _buildDropdown(
                hint: "Select",
                value: selectedMaidFor,
                items: maidForOptions,
                onChanged: (value) => setState(() => selectedMaidFor = value),
              ),
              SizedBox(height: 25),
              Text(
                "Requirement",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              _buildDropdown(
                hint: "Select",
                value: selectedRequirement,
                items: requirementOptions,
                onChanged:
                    (value) => setState(() => selectedRequirement = value),
              ),
              SizedBox(height: 25),

              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (selectedMaidFor == null ||
                        selectedRequirement == null ||
                        selectedLocationSuggestion == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          duration: const Duration(seconds: 3),
                          content: Row(
                            children: const [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Please fill all fields before continuing",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => MaidRequestForm(
                              selectedLocation:
                                  selectedLocationSuggestion.toString(),
                              maidFor: selectedMaidFor.toString(),
                              requirements: selectedRequirement.toString(),
                            ),
                      ),
                    );
                  },

                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      hint: Text(hint),
      value: value,
      onChanged: onChanged,
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
    );
  }

  // Widget _buildRadio(String gender) {
  //   return Row(
  //     children: [
  //       Radio<String>(
  //         value: gender,
  //         groupValue: selectedGender,
  //         onChanged: (value) => setState(() => selectedGender = value),
  //         activeColor: Theme.of(context).colorScheme.primary,
  //       ),
  //       Text(gender),
  //     ],
  //   );
  // }
}
