import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kaamwaalibais/models/salary_budget_model.dart';
import 'package:kaamwaalibais/models/super_catogries_model.dart';
import 'package:kaamwaalibais/models/time_slot_moel.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';

class MaidRegistrationForm extends StatefulWidget {
  const MaidRegistrationForm({super.key});

  @override
  State<MaidRegistrationForm> createState() => _MaidRegistrationFormState();
}

class _MaidRegistrationFormState extends State<MaidRegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  String? selectedSlotId;
  String? selectedReligion;
  String? selectedPackage;

  final List<Map<String, String>> religions = [
    {"id": "1", "name": "Hindu"},
    {"id": "2", "name": "Muslim"},
    {"id": "9", "name": "Christian"},
  ];

  // Dropdown selections
  String? selectedSuperCategory;
  int? selectedReligionId;
  String? selectedCityId,
      gender,
      maritalStatus,
      salary,
      workExp,
      timeSlot,
      religion,
      mainService;

  // File variables
  File? photo, panCard, aadhaarCard;

  // City data
  List<dynamic> cities = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    setState(() {
      cities = [
        {"id": "1", "name": "Delhi"},
        {"id": "2", "name": "Mumbai"},
        {"id": "3", "name": "Bangalore"},
        {"id": "4", "name": "Hyderabad"},
        {"id": "5", "name": "Pune"},
        {"id": "6", "name": "Chennai"},
        {"id": "7", "name": "Kolkata"},
        {"id": "8", "name": "Ahmedabad"},
        {"id": "9", "name": "Jaipur"},
        {"id": "10", "name": "Surat"},
        {"id": "11", "name": "Lucknow"},
        {"id": "12", "name": "Kanpur"},
        {"id": "13", "name": "Nagpur"},
        {"id": "14", "name": "Indore"},
        {"id": "15", "name": "Bhopal"},
        {"id": "16", "name": "Patna"},
        {"id": "17", "name": "Vadodara"},
        {"id": "18", "name": "Ludhiana"},
        {"id": "19", "name": "Agra"},
        {"id": "20", "name": "Varanasi"},
        {"id": "21", "name": "Rajkot"},
        {"id": "22", "name": "Ranchi"},
        {"id": "23", "name": "Meerut"},
        {"id": "24", "name": "Faridabad"},
        {"id": "25", "name": "Ghaziabad"},
        {"id": "26", "name": "Coimbatore"},
        {"id": "27", "name": "Kochi"},
        {"id": "28", "name": "Thiruvananthapuram"},
        {"id": "29", "name": "Visakhapatnam"},
        {"id": "30", "name": "Vijayawada"},
        {"id": "31", "name": "Mysore"},
        {"id": "32", "name": "Mangalore"},
        {"id": "33", "name": "Jodhpur"},
        {"id": "34", "name": "Udaipur"},
        {"id": "35", "name": "Guwahati"},
        {"id": "36", "name": "Shillong"},
        {"id": "37", "name": "Dehradun"},
        {"id": "38", "name": "Haridwar"},
        {"id": "39", "name": "Noida"},
        {"id": "40", "name": "Gurugram"},
        {"id": "41", "name": "Chandigarh"},
        {"id": "42", "name": "Amritsar"},
        {"id": "43", "name": "Jalandhar"},
        {"id": "44", "name": "Allahabad (Prayagraj)"},
        {"id": "45", "name": "Gwalior"},
        {"id": "46", "name": "Jabalpur"},
        {"id": "47", "name": "Aurangabad"},
        {"id": "48", "name": "Nashik"},
        {"id": "49", "name": "Kolhapur"},
        {"id": "50", "name": "Solapur"},
      ];

      isLoading = false;
    });
  }

  // Image picker
  final ImagePicker picker = ImagePicker();

  Future<void> pickFile(Function(File) onPicked) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onPicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "Maid Registration Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  buildFilePicker(
                    "Photo",
                    photo,
                    (f) => setState(() => photo = f),
                  ),
                  buildTextField("Maid Name *", nameController),
                  buildTextField("Address", addressController, flex: 2),
                  buildTextField("Area *", areaController),

                  // ✅ City Dropdown from API
                  SizedBox(
                    width:
                        MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.width > 600 ? 2 : 1) -
                        20,
                    child:
                        isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : DropdownButtonFormField<String>(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              value: selectedCityId,
                              validator:
                                  (val) =>
                                      (val == null || val.isEmpty)
                                          ? "Required"
                                          : null,
                              decoration: InputDecoration(
                                labelText: "City *",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: "",
                                  child: Text("Select City"),
                                ),
                                ...cities.map((city) {
                                  return DropdownMenuItem<String>(
                                    value: city["name"].toString(),
                                    child: Text(city["name"]),
                                  );
                                }),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedCityId = value;
                                });
                                print("Selected City ID: $value");
                              },
                            ),
                  ),

                  buildTextField(
                    "Phone no *",
                    phoneController,
                    keyboard: TextInputType.phone,
                  ),
                  buildTextField(
                    "Age *",
                    ageController,
                    keyboard: TextInputType.number,
                  ),
                  buildDropdown(
                    "Gender (optional)",
                    ["Male", "Female"],
                    gender,
                    (val) {
                      setState(() => gender = val);
                    },
                  ),
                  buildDropdown(
                    "Marital Status (optional)",
                    ["Single", "Married", "Widow"],
                    maritalStatus,
                    (val) {
                      setState(() => maritalStatus = val);
                    },
                  ),
                  DropdownButtonFormField<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: "Select Religion (optional)",
                      border: OutlineInputBorder(),
                    ),
                    value: selectedReligion,
                    items:
                        religions
                            .map(
                              (religion) => DropdownMenuItem(
                                value: religion["id"], // store ID
                                child: Text(religion["name"]!), // show name
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedReligion = value;
                        log(selectedReligion.toString());
                      });
                      // log("Selected Religion ID: $value");
                      // log(
                      //   "Selected Religion Name: ${religions.firstWhere((r) => r["id"] == value)["name"]}",
                      // );
                    },
                  ),
                  buildTextField("Language", languageController),
                  FutureBuilder<PackageModel?>(
                    future: fetchPackages(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox.shrink();
                      } else if (snapshot.hasError) {
                        return const Text("Error loading packages");
                      } else if (!snapshot.hasData || snapshot.data == null) {
                        return const Text("No packages available");
                      }

                      final packages = snapshot.data!.data;

                      return DropdownButtonFormField<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: "Select Package",
                          border: OutlineInputBorder(),
                        ),
                        value: selectedPackage,
                        items:
                            packages.entries.map((entry) {
                              return DropdownMenuItem(
                                value: entry.key, // store ID
                                child: Text(
                                  entry.value,
                                ), // show value (e.g. 8 Hours - Rs.14000)
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPackage = value;
                          });
                          log("Selected Package ID: $value");
                          log("Selected Package: ${packages[value]}");
                        },
                      );
                    },
                  ),
                  buildDropdown(
                    "Work Experience",
                    ["<1 yr", "1-3 yrs", "3-5 yrs", "5+ yrs"],
                    workExp,
                    (val) {
                      setState(() => workExp = val);
                    },
                  ),
                  FutureBuilder<TimeslotModel?>(
                    future: timeSlotApi(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox.shrink();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData ||
                          snapshot.data?.data == null) {
                        return const Text("No data found");
                      }

                      final timeslotMap = snapshot.data!.data!;
                      // Remove empty & "Select"
                      final validSlots =
                          timeslotMap.entries
                              .where(
                                (entry) =>
                                    entry.value.isNotEmpty &&
                                    entry.value != "Select",
                              )
                              .toList();

                      return StatefulBuilder(
                        builder: (context, setState) {
                          return DropdownButtonFormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              labelText: "Select Time Slot",
                              border: OutlineInputBorder(),
                            ),
                            value: selectedSlotId,
                            items:
                                validSlots
                                    .map(
                                      (entry) => DropdownMenuItem(
                                        value:
                                            entry
                                                .key, // store ID here (e.g. "6")
                                        child: Text(
                                          entry.value,
                                        ), // show value (e.g. "9 AM - 7 PM")
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSlotId = value;
                              });
                              log("Selected ID: $value"); // e.g. "6"
                              log(
                                "Selected Slot: ${timeslotMap[value]}",
                              ); // e.g. "9 AM - 7 PM"
                            },
                          );
                        },
                      );
                    },
                  ),

                  buildFilePicker(
                    "PAN No. (optional)",
                    panCard,
                    (f) => setState(() => panCard = f),
                  ),
                  buildFilePicker(
                    "Aadhaar Card No. (optional)",
                    aadhaarCard,
                    (f) => setState(() => aadhaarCard = f),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Services Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Services",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<SuperCategoryModel?>(
                future: fetchSuperCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox.fromSize();
                  } else if (snapshot.hasError) {
                    return const Text("Error loading supercategories");
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text("No data found");
                  }

                  final categories = snapshot.data!.data;

                  return DropdownButtonFormField<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(
                      labelText: "Select Supercategory",
                      border: OutlineInputBorder(),
                    ),
                    value: selectedSuperCategory,
                    items:
                        categories.entries.map((entry) {
                          return DropdownMenuItem(
                            value: entry.key, // store ID
                            child: Text(entry.value), // show name
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSuperCategory = value;
                      });
                      print("Selected Supercategory ID: $value");
                      print(
                        "Selected Supercategory Name: ${categories[value]}",
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      EasyLoading.show();
                      final maidFormData = await maidRegistrationFormApi(
                        nameController.text,
                        selectedCityId ?? "",
                        areaController.text,
                        addressController.text,
                        languageController.text,
                        phoneController.text,
                        ageController.text,
                        maritalStatus ?? "",
                        gender ?? "Not prefer to say",
                        selectedReligion.toString(),
                        workExp ?? "",
                        selectedPackage ?? "",
                        selectedSlotId ?? "",
                        selectedSuperCategory ?? "",
                      );

                      if (maidFormData == 200) {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            backgroundColor: Colors.green.shade600,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            content: Row(
                              children: const [
                                Icon(Icons.check_circle, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Form Submitted Successfully 🎉",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                        Navigator.pop(context);
                      } else {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(16),
                            backgroundColor: Colors.red.shade600,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            content: Row(
                              children: const [
                                Icon(Icons.error_outline, color: Colors.white),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Submission Failed! Please try again ❌",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Widgets
  Widget buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboard = TextInputType.text,
    int flex = 1,
  }) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.width > 600 ? 2 : 1) -
          20,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        keyboardType: label == "Phone no *" ? TextInputType.phone : keyboard,
        maxLength: label == "Phone no *" ? 10 : null,
        validator: (val) => val == null || val.isEmpty ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    // if (label == "Hindu") {
    //   setState(() {
    //     selectedReligionId = 1;
    //   });
    // } else if (label == "Muslim") {
    //   setState(() {
    //     selectedReligionId = 2;
    //   });
    // } else {
    //   selectedReligionId = 9;
    // }
    // log(selectedReligionId.toString());
    return SizedBox(
      width:
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.width > 600 ? 2 : 1) -
          20,
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: value,
        // validator: (val) => (val == null || val.isEmpty) ? "Required" : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget buildFilePicker(String label, File? file, Function(File) onPicked) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.width > 600 ? 2 : 1) -
          20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => pickFile(onPicked),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text(
                  "Choose File",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  file != null ? file.path.split('/').last : "No file chosen",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
