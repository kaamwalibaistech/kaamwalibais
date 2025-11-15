import 'package:flutter/material.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  final GetUserlogIn? userdata;
  const UpdateProfileScreen({super.key, required this.userdata});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController countryController;

  final List<String> states = ["Maharashtra", "Gujarat", "Delhi", "Karnataka"];
  final List<String> cities = ["Thane", "Mumbai", "Pune", "Nagpur"];

  String? selectedState;
  String? selectedCity;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.userdata?.user?.name ?? "",
    );
    emailController = TextEditingController(
      text: widget.userdata?.user?.emailid ?? "",
    );
    phoneController = TextEditingController(
      text: widget.userdata?.user?.mobileno ?? "",
    );
    addressController = TextEditingController(
      text: widget.userdata?.user?.address ?? "",
    );
    countryController = TextEditingController(
      text: widget.userdata?.user?.country ?? "",
    );
  }

  @override
  void dispose() {
    // Always dispose controllers
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Update Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Full Name", nameController),
              const SizedBox(height: 10),
              _buildTextField("Email", emailController),
              const SizedBox(height: 10),
              _buildTextField(
                "Mobile Number",
                phoneController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              _buildTextField("Address", addressController, maxLines: 3),
              const SizedBox(height: 20),

              Text(
                "State",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedState,
                hint: const Text("select"),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items:
                    states
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              Text(
                "City",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedCity,
                hint: const Text("select"),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items:
                    cities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCity = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              Text(
                "Country",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              _buildTextField("Country", countryController),

              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        content: Text("Working on it"),
                      ),
                    );

                    // Save details logic here
                    debugPrint("Name: ${nameController.text}");
                    debugPrint("Email: ${emailController.text}");
                    debugPrint("Phone: ${phoneController.text}");
                    debugPrint("Address: ${addressController.text}");
                    debugPrint("State: $selectedState");
                    debugPrint("City: $selectedCity");
                    debugPrint("Country: ${countryController.text}");
                  },
                  child: const Text(
                    "SAVE DETAILS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
