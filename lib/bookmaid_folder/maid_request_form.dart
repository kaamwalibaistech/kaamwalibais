import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

class MaidRequestForm extends StatefulWidget {
  final String selectedLocation;
  final String maidFor;
  final String requirements;
  final String name;
  final String email;
  final String phoneNumber;

  const MaidRequestForm({
    super.key,
    required this.selectedLocation,
    required this.maidFor,
    required this.requirements,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<MaidRequestForm> createState() => _MaidRequestFormState();
}

class _MaidRequestFormState extends State<MaidRequestForm> {
  String? selectedHours;
  String? selectedPrice;
  String? numberOfPeople;
  String? houseSize;
  String? religion;
  String? gender;
  String? agePreference;

  bool houseMaid = false;
  bool cookingHelp = false;
  bool bathroomCleaning = false;
  bool clothesWashing = false;
  bool dusting = false;
  bool floorCleaning = false;
  bool groceryShopping = false;
  bool utensilCleaning = false;

  bool agreeTerms = false;

  /// Validation flags
  bool showHourError = false;
  bool showPeopleError = false;
  bool showHouseSizeError = false;
  bool showGenderError = false;
  bool showAgeError = false;
  bool showTermsError = false;

  final TextEditingController? commentController = TextEditingController();

  final List<Map<String, String>> hoursOptions = [
    {"label": "1 Hours Daily", "price": "₹5000"},
    {"label": "2 Hours Daily", "price": "₹8000"},
    {"label": "4 Hours Daily", "price": "₹9000"},
    {"label": "6 Hours Daily", "price": "₹12000"},
    {"label": "8 Hours Daily", "price": "₹14000"},
    {"label": "10 Hours Daily", "price": "₹16000"},
    // {"label": "11 Hours Daily", "price": "₹17000"},
    {"label": "12 Hours Daily", "price": "₹18000"},
    {"label": "24 Hours Daily", "price": "₹20000"},
  ];

  GetUserlogIn? userData;

  @override
  void initState() {
    super.initState();
    userData = LocalStoragePref().getLoginModel();
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
          "Maid Service Form",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HOURS GRID
            const Text(
              "Number of hours you need the maid for *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 2 : 4,
                childAspectRatio: screenWidth < 600 ? 3 : 2.5,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: hoursOptions.length,
              itemBuilder: (context, index) {
                final option = hoursOptions[index];
                final isSelected = selectedHours == option["label"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedHours = option["label"];
                      selectedPrice = option["price"];
                      showHourError = false;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.yellow[700],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color:
                            showHourError && selectedHours == null
                                ? Colors.red
                                : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            option["label"]!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Flexible(
                          child: Text(
                            "Salary ${option["price"]} / Month",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (showHourError && selectedHours == null)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Please select hours",
                  style: TextStyle(color: Colors.red),
                ),
              ),

            const SizedBox(height: 16),

            /// PEOPLE
            buildDropdown(
              "Number of people in house *",
              ["1-2", "3-5", "6+"],
              numberOfPeople,
              (val) {
                setState(() {
                  numberOfPeople = val;
                  showPeopleError = false;
                });
              },
              showError: showPeopleError && numberOfPeople == null,
            ),
            if (showPeopleError && numberOfPeople == null)
              const Text(
                "Please select number of people",
                style: TextStyle(color: Colors.red),
              ),

            /// HOUSE SIZE
            buildDropdown(
              "Size of the house *",
              ["1BHK", "2BHK", "3BHK", "Villa"],
              houseSize,
              (val) {
                setState(() {
                  houseSize = val;
                  showHouseSizeError = false;
                });
              },
              showError: showHouseSizeError && houseSize == null,
            ),
            if (showHouseSizeError && houseSize == null)
              const Text(
                "Please select house size",
                style: TextStyle(color: Colors.red),
              ),

            /// RELIGION (optional)
            buildDropdown(
              "Religion preference (if any)",
              ["Any", "Hindu", "Muslim", "Christian"],
              religion,
              (val) {
                setState(() => religion = val);
              },
            ),

            /// GENDER
            const Text(
              "Gender Preferences *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Male"),
                    value: "Male",
                    groupValue: gender,
                    activeColor: Colors.purple,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                        showGenderError = false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text("Female"),
                    value: "Female",
                    groupValue: gender,
                    activeColor: Colors.purple,
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                        showGenderError = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (showGenderError && gender == null)
              const Text(
                "Please select gender",
                style: TextStyle(color: Colors.red),
              ),

            /// AGE
            buildDropdown(
              "Age Preferences *",
              ["18-25", "26-35", "36-50", "50+"],
              agePreference,
              (val) {
                setState(() {
                  agePreference = val;
                  showAgeError = false;
                });
              },
              showError: showAgeError && agePreference == null,
            ),
            if (showAgeError && agePreference == null)
              const Text(
                "Please select age preference",
                style: TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 16),

            /// TOGGLES (services)
            const Text(
              "HOUSEMAID",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            buildSwitch("House Maid", houseMaid, (val) {
              setState(() => houseMaid = val);
            }),
            buildSwitch("Cooking Help", cookingHelp, (val) {
              setState(() => cookingHelp = val);
            }),
            buildSwitch("Bathroom Cleaning", bathroomCleaning, (val) {
              setState(() => bathroomCleaning = val);
            }),
            buildSwitch("Clothes Washing", clothesWashing, (val) {
              setState(() => clothesWashing = val);
            }),
            buildSwitch("Dusting", dusting, (val) {
              setState(() => dusting = val);
            }),
            buildSwitch("Floor Cleaning", floorCleaning, (val) {
              setState(() => floorCleaning = val);
            }),
            buildSwitch("Grocery Shopping", groceryShopping, (val) {
              setState(() => groceryShopping = val);
            }),
            buildSwitch("Utensil Cleaning", utensilCleaning, (val) {
              setState(() => utensilCleaning = val);
            }),

            const SizedBox(height: 16),

            /// COMMENTS
            const Text("Any other Comments"),
            const SizedBox(height: 5),
            TextField(
              controller: commentController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter any comments",
              ),
            ),

            const SizedBox(height: 16),

            /// TERMS
            Row(
              children: [
                Checkbox(
                  value: agreeTerms,
                  onChanged: (val) {
                    setState(() {
                      agreeTerms = val!;
                      showTermsError = false;
                    });
                  },
                ),
                const Expanded(
                  child: Text(
                    "I agree to the terms and conditions of Kamwalibais",
                  ),
                ),
              ],
            ),
            if (showTermsError && !agreeTerms)
              const Text(
                "You must agree to terms",
                style: TextStyle(color: Colors.red),
              ),

            const SizedBox(height: 16),

            /// SUBMIT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _handleSubmit,
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
    );
  }

  /// Submit Handler with Validation
  void _handleSubmit() async {
    setState(() {
      showHourError = selectedHours == null;
      showPeopleError = numberOfPeople == null;
      showHouseSizeError = houseSize == null;
      showGenderError = gender == null;
      showAgeError = agePreference == null;
      showTermsError = !agreeTerms;
    });

    if (showHourError ||
        showPeopleError ||
        showHouseSizeError ||
        showGenderError ||
        showAgeError ||
        showTermsError) {
      return;
    }

    EasyLoading.show();
    final message = await maidEnquiryMailSendApi(
      widget.name,
      widget.phoneNumber,
      widget.email,
      widget.selectedLocation,
      widget.requirements,
      selectedHours ?? "",
      gender ?? "",
      selectedHours ?? "",
      selectedPrice ?? "",
      numberOfPeople ?? "",
      houseSize ?? "",
      religion ?? "",
      agePreference ?? "",
      widget.maidFor,
      commentController?.text ?? "",
    );

    EasyLoading.dismiss();

    if (message is String && message == "success") {
      setState(() {
        selectedHours = null;
        selectedPrice = null;
        numberOfPeople = null;
        houseSize = null;
        religion = null;
        gender = null;
        agePreference = null;
        houseMaid = false;
        cookingHelp = false;
        bathroomCleaning = false;
        clothesWashing = false;
        dusting = false;
        floorCleaning = false;
        groceryShopping = false;
        utensilCleaning = false;
        agreeTerms = false;
      });
      commentController?.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(
          "Form submitted successfully!",
          Colors.green,
          Icons.check_circle,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        _buildSnackBar(
          "Something went wrong. Please try again!",
          Colors.red,
          Icons.error_outline,
        ),
      );
    }
  }

  /// Helper: Dropdown
  Widget buildDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged, {
    bool showError = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          errorText: showError ? "Required" : null,
        ),
        value: value,
        onChanged: onChanged,
        items:
            items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
      ),
    );
  }

  /// Helper: Switch
  Widget buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.purple,
    );
  }

  /// Helper: SnackBar
  SnackBar _buildSnackBar(String text, Color bg, IconData icon) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
