import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

class MaidRequestForm extends StatefulWidget {
  final String? selectedLocation;
  final String? maidFor;
  final String? requirements;
  const MaidRequestForm({
    super.key,
    this.selectedLocation,
    this.maidFor,
    this.requirements,
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

  final TextEditingController? commentController = TextEditingController();

  final List<Map<String, String>> hoursOptions = [
    {"label": "1 Hours Daily", "price": "₹5000"},
    {"label": "2 Hours Daily", "price": "₹8000"},
    {"label": "4 Hours Daily", "price": "₹9000"},
    {"label": "6 Hours Daily", "price": "₹12000"},
    {"label": "8 Hours Daily", "price": "₹14000"},
    {"label": "10 Hours Daily", "price": "₹16000"},
    {"label": "11 Hours Daily", "price": "₹17000"},
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
          child: Icon(Icons.arrow_back, color: Colors.white),
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
            const Text(
              "Number of hours you need the maid for *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Hours Selection Grid
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 2 : 4,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: hoursOptions.length,
              itemBuilder: (context, index) {
                final option = hoursOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedHours = option["label"];
                      selectedPrice = option["price"];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          selectedHours == option["label"]
                              ? Colors.purple
                              : Colors.yellow[700],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          option["label"]!,
                          style: TextStyle(
                            color:
                                selectedHours == option["label"]
                                    ? Colors.white
                                    : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Salary ${option["price"]} / Month",
                          style: TextStyle(
                            color:
                                selectedHours == option["label"]
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Dropdowns
            buildDropdown(
              "Number of people in house *",
              ["1-2", "3-5", "6+"],
              numberOfPeople,
              (val) {
                setState(() => numberOfPeople = val);
              },
            ),
            buildDropdown(
              "Size of the house *",
              ["1BHK", "2BHK", "3BHK", "Villa"],
              houseSize,
              (val) {
                setState(() => houseSize = val);
              },
            ),
            buildDropdown(
              "Religion preference (if any)",
              ["Any", "Hindu", "Muslim", "Christian"],
              religion,
              (val) {
                setState(() => religion = val);
              },
            ),
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
                      setState(() => gender = val);
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
                      setState(() => gender = val);
                    },
                  ),
                ),
              ],
            ),

            // buildDropdown("Gender Preferences *", ["Male", "Female"], gender, (
            //   val,
            // ) {
            //   setState(() => gender = val);
            // }),
            buildDropdown(
              "Age Preferences *",
              ["18-25", "26-35", "36-50", "50+"],
              agePreference,
              (val) {
                setState(() => agePreference = val);
              },
            ),

            const SizedBox(height: 16),

            // Toggles
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

            // Comments
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

            // Terms
            Row(
              children: [
                Checkbox(
                  value: agreeTerms,
                  onChanged: (val) {
                    setState(() => agreeTerms = val!);
                  },
                ),
                const Expanded(
                  child: Text(
                    "I agree to the terms and conditions of Kamwalibais",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  if (!agreeTerms) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // rounded corners
                        ),
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ), // margin from screen edges
                        duration: const Duration(seconds: 3),
                        content: Row(
                          children: [
                            const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "Please agree to terms and conditions",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        action: SnackBarAction(
                          label: "OK",
                          textColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    );

                    return;
                  } else {
                    if ((selectedHours != null && selectedHours!.isNotEmpty) &&
                        (numberOfPeople != null &&
                            numberOfPeople!.isNotEmpty) &&
                        (houseSize != null && houseSize!.isNotEmpty) &&
                        (gender != null && gender!.isNotEmpty) &&
                        (agePreference != null && agePreference!.isNotEmpty)) {
                      EasyLoading.show();
                      final message = await maidEnquiryMailSendApi(
                        userData?.user?.name ?? "",
                        userData?.user?.mobileno ?? "",
                        userData?.user?.emailid ?? "",
                        widget.selectedLocation ?? "",
                        widget.requirements ?? "",
                        selectedHours ?? "",
                        gender ?? "",
                        selectedHours ?? "",
                        selectedPrice ?? "",
                        numberOfPeople ?? "",
                        houseSize ?? "",
                        religion ?? "",
                        agePreference ?? "",
                        widget.maidFor ?? "",
                        commentController?.text ?? "",
                      );
                      if (message is String && message == "success") {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
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
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Form submitted successfully!",
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
                      } else {
                        EasyLoading.dismiss();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
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
                                  Icons.error_outline,
                                  color: Colors.white,
                                  size: 26,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "Something went wrong. Please try again!",
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
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.orange.shade700,
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
                                  "Please fill in all required fields",
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget buildDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
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

  Widget buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.purple,
    );
  }
}
