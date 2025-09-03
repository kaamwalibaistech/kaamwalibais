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
  // void showLoginDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // user must tap button
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         title: const Text(
  //           "Please Log In",
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
  //         ),
  //         content: const Text(
  //           "You need to log in to continue using this feature.",
  //           style: TextStyle(fontSize: 15),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // dismiss dialog
  //             },
  //             child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
  //           ),
  //           ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.purple,
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             onPressed: () {
  //               Navigator.pushAndRemoveUntil(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => const LoginScreen()),
  //                 (Route<dynamic> route) => false,
  //               );
  //             },

  //             child: const Text(
  //               "Log In",
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // String? selectedGender;
  final formKey = GlobalKey<FormState>();
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
          child: Form(
            key: formKey,
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

                TextFormField(
                  controller:
                      nameController, // make sure you created this controller
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
                SizedBox(height: 30),
                TextFormField(
                  controller:
                      emailController, // make sure this controller is defined
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
                SizedBox(height: 30),
                TextFormField(
                  controller:
                      mobileController, // make sure this controller is defined
                  keyboardType: TextInputType.phone,
                  maxLength: 10, // restrict to 10 digits
                  decoration: InputDecoration(
                    hintText: "Enter Mobile Number",
                    labelText: "Phone Number",
                    prefixIcon: const Icon(Icons.phone),
                    counterText: "", // hides the character counter
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
                // SizedBox(height: 25),
                // Text(
                //   "Requirement",
                //   style: TextStyle(fontWeight: FontWeight.w600),
                // ),
                // SizedBox(height: 8),
                // _buildDropdown(
                //   hint: "Select",
                //   value: selectedRequirement,
                //   items: requirementOptions,
                //   onChanged:
                //       (value) => setState(() => selectedRequirement = value),
                // ),
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
                      // final userData = LocalStoragePref().getLoginModel();

                      if (selectedMaidFor == null ||
                          selectedLocationSuggestion == null ||
                          nameController.text.isEmpty ||
                          mobileController.text.isEmpty ||
                          !formKey.currentState!.validate()) {
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
                                name: nameController.text,
                                email: emailController.text,
                                phoneNumber: mobileController.text,
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
