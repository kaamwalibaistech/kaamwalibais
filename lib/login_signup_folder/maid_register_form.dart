import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  // Dropdown selections
  String? city,
      gender,
      maritalStatus,
      salary,
      workExp,
      timeSlot,
      religion,
      mainService;

  // File variables
  File? photo, panCard, aadhaarCard;

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
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Maid Registration Form"),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Responsive layout using Wrap
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
                  buildDropdown(
                    "City *",
                    ["Delhi", "Mumbai", "Bangalore"],
                    city,
                    (val) {
                      setState(() => city = val);
                    },
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
                  buildDropdown("Gender *", ["Male", "Female"], gender, (val) {
                    setState(() => gender = val);
                  }),
                  buildDropdown(
                    "Marital Status *",
                    ["Single", "Married", "Widow"],
                    maritalStatus,
                    (val) {
                      setState(() => maritalStatus = val);
                    },
                  ),
                  buildDropdown(
                    "Religion",
                    ["Hindu", "Muslim", "Christian", "Other"],
                    religion,
                    (val) {
                      setState(() => religion = val);
                    },
                  ),
                  buildTextField("Language", languageController),
                  buildDropdown(
                    "Salary Budget *",
                    ["5k-10k", "10k-15k", "15k-20k"],
                    salary,
                    (val) {
                      setState(() => salary = val);
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
                  buildDropdown(
                    "Time slot",
                    ["Morning", "Afternoon", "Evening", "Full Day"],
                    timeSlot,
                    (val) {
                      setState(() => timeSlot = val);
                    },
                  ),
                  buildFilePicker(
                    "PAN No.",
                    panCard,
                    (f) => setState(() => panCard = f),
                  ),
                  buildFilePicker(
                    "Aadhaar Card No.",
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
              buildDropdown(
                "Select Main Service",
                ["Cooking", "Cleaning", "Babysitting"],
                mainService,
                (val) {
                  setState(() => mainService = val);
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Form Submitted Successfully"),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
        controller: controller,
        keyboardType: keyboard,
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
    return SizedBox(
      width:
          MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.width > 600 ? 2 : 1) -
          20,
      child: DropdownButtonFormField<String>(
        value: value,
        validator: (val) => (val == null || val.isEmpty) ? "Required" : null,
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
                child: const Text("Choose File"),
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
