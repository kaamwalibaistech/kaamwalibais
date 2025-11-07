import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/login_signup_folder/login_screen.dart';
import 'package:kaamwaalibais/models/user_login_model.dart';
import 'package:kaamwaalibais/profile_folder/manage_profile_page.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GetUserlogIn? userdata;
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    userdata = LocalStoragePref.instance!.getLoginModel();
  }

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
          foregroundColor: Theme.of(context).colorScheme.primary,
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
          title: Text("Profile", style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height * 0.20,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  subtitleTextStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  title: Text(userdata?.user?.name ?? "NA"),
                  subtitle: Text(userdata?.user?.emailid ?? "NA"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => UpdateProfileScreen(userdata: userdata),
                    ),
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 1,
                    shadowColor: Theme.of(context).colorScheme.primaryContainer,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.manage_accounts_outlined),
                        SizedBox(width: 12),
                        Text(
                          "Manage Your Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () async {
                  await LocalStoragePref.instance!.clearAllPref();

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: SizedBox(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 1,
                    shadowColor: Theme.of(context).colorScheme.primaryContainer,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout_rounded),
                        SizedBox(width: 8),
                        Text(
                          "Sign Out",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              userdata?.user?.mobileno == "8169669043"
                  ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,

                    width: MediaQuery.of(context).size.width * 10,
                    child: ElevatedButton(
                      onPressed: () async {
                        final confirmed = await showDialog(
                          context: context,
                          builder:
                              (_) => AlertDialog(
                                title: Text('Delete Account?'),
                                content: Text(
                                  'This action will permanently delete your account and data.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: Text('Delete'),
                                  ),
                                ],
                              ),
                        );
                        if (confirmed) {
                          await LocalStoragePref.instance!.clearAllPref();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.red,
                              content: Text(
                                "Your Account has deleted Successfully",
                              ),
                            ),
                          );

                          await LocalStoragePref.instance!
                              .temproraryAccDelete();
                          // await deleteUserAccount(); // your API call
                          // redirect to login or home
                        }
                      },
                      child: Text('Delete Account'),
                    ),
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
