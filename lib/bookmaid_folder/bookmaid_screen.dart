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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController locationValue = TextEditingController();

  final formKey = GlobalKey<FormState>();
  SearchLocationModel? searchLocationModel;
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

  Future<SearchLocationModel> getLocation(String searchKey) async {
    log("Log: enableLocation");
    loc.Location location = loc.Location();

    if (!await location.serviceEnabled()) {
      await location.requestService();
    }

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

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    locationValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationScreen(destinations: 0),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Book Maid"),
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationScreen(destinations: 0),
                ),
              );
            },
          ),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    "Find Professional Maid",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 30),

                /// Name
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Name",
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    } else if (value.length < 3) {
                      return "Enter at least 3 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                /// Email
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                /// Phone
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                    counterText: "",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone number is required";
                    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                /// Location (TypeAhead)
                TypeAheadField<String>(
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) return [];
                    try {
                      final result = await getLocation(pattern);
                      if (!mounted) return [];
                      searchLocationModel = result;
                      log(searchLocationModel!.predictions.first.description);
                      return searchLocationModel!.predictions
                          .map((prediction) => prediction.description)
                          .toList();
                    } catch (e) {
                      log(e.toString());
                      return [];
                    }
                  },
                  itemBuilder: (context, String suggestion) {
                    return ListTile(
                      leading: const Icon(Icons.location_on_outlined),
                      title: Text(suggestion),
                    );
                  },
                  onSelected: (String suggestion) {
                    if (!mounted) return;
                    setState(() {
                      selectedLocationSuggestion = suggestion;
                    });
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("You selected $suggestion")),
                      );
                    }
                  },
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
                          prefixIcon: const Icon(Icons.search),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),

                /// Maid For
                const Text(
                  "I need maid for...",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                _buildDropdown(
                  hint: "Select",
                  value: selectedMaidFor,
                  items: maidForOptions,
                  onChanged: (value) => setState(() => selectedMaidFor = value),
                ),
                const SizedBox(height: 25),

                /// Continue button
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
                          selectedLocationSuggestion == null ||
                          nameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          !formKey.currentState!.validate()) {
                        if (!mounted) return;
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

                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => MaidRequestForm(
                                selectedLocation:
                                    selectedLocationSuggestion.toString(),
                                maidFor: selectedMaidFor.toString(),
                                requirements: selectedRequirement.toString(),
                                name: nameController.text,
                                email: emailController.text,
                                phoneNumber: mobileController.text,
                              ),
                        ),
                      );
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
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
}
