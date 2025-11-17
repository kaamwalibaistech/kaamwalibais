import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/bookmaid_folder/maid_request_form.dart';
import 'package:kaamwaalibais/models/searchlocation_model.dart';

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
            // autovalidateMode:
            //     AutovalidateMode.onUserInteraction, //  auto validation
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
                  decoration: _inputDecoration(
                    "Name",
                    "Enter Your Name",
                    Icons.person,
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
                  decoration: _inputDecoration(
                    "Email",
                    "Enter Your Email",
                    Icons.email,
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
                  decoration: _inputDecoration(
                    "Phone Number",
                    "Enter Mobile Number",
                    Icons.phone,
                  ).copyWith(counterText: ""),
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
                  controller: locationValue,
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) return [];
                    try {
                      final result = await getLocation(pattern);
                      if (!mounted) return [];
                      searchLocationModel = result;
                      return searchLocationModel!.predictions
                          .map((p) => p.description)
                          .toList();
                    } catch (e) {
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
                    setState(() {
                      selectedLocationSuggestion = suggestion;
                      locationValue.text = suggestion;
                    });
                  },
                  builder: (context, controller, focusNode) {
                    return TextFormField(
                      controller: controller,
                      focusNode: focusNode,
                      readOnly: selectedLocationSuggestion != null,
                      decoration: _inputDecoration(
                        "Search Location",
                        "Enter Location",
                        Icons.search,
                      ),
                      validator: (_) {
                        if (selectedLocationSuggestion == null) {
                          return "Location is required";
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 25),

                /// Maid For
                const Text(
                  "I need maid for...",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                _buildDropdown(
                  hint: "Select",
                  value: selectedMaidFor,
                  items: maidForOptions,
                  onChanged: (value) => setState(() => selectedMaidFor = value),
                  validator:
                      (value) =>
                          value == null ? "Please select a maid type" : null,
                ),
                const SizedBox(height: 25),

                /// Requirement
                // const Text(
                //   "Requirement Time",
                //   style: TextStyle(fontWeight: FontWeight.w600),
                // ),
                // const SizedBox(height: 10),
                // _buildDropdown(
                //   hint: "Select Requirement",
                //   value: selectedRequirement,
                //   items: requirementOptions,
                //   onChanged:
                //       (value) => setState(() => selectedRequirement = value),
                //   validator:
                //       (value) =>
                //           value == null ? "Please select requirement" : null,
                // ),
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
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Please fill all the Required Fields",
                            ),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      }
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

  InputDecoration _inputDecoration(String label, String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blueGrey),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
    required String? Function(String?) validator,
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
      validator: validator,
      items:
          items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
    );
  }
}
