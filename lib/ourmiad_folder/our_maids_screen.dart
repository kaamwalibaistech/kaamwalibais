import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/models/maidlist_model.dart';
import 'package:kaamwaalibais/ourmiad_folder/our_maid_details_screen.dart';
import 'package:kaamwaalibais/single_pages/contactus_page.dart';
import 'package:kaamwaalibais/utils/api_repo.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';

import '../utils/snackbar.dart';

class OurMaidsScreen extends StatefulWidget {
  const OurMaidsScreen({super.key});

  @override
  State<OurMaidsScreen> createState() => _OurMaidsScreenState();
}

class _OurMaidsScreenState extends State<OurMaidsScreen> {
  MaidlistModel? maidlistModel;
  @override
  void initState() {
    super.initState();
    gatMaidList();
  }

  gatMaidList() async {
    String token = LocalStoragePref().gsetLoginTocken() ?? "";
    final data = await maidLists(token);
    if (mounted) {
      setState(() {
        maidlistModel = data;
      });
    }
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
          title: Text(
            "Our Maids",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body:
            maidlistModel == null
                ? Center(child: const CircularProgressIndicator())
                : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: maidlistModel?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final maid = maidlistModel?.data?[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => OurMaidDetailsScreen(
                                  data: maidlistModel?.data?[index],
                                ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: maid?.photo ?? "",
                                width: 150,
                                // height: 100,
                                fit: BoxFit.cover,
                                placeholder:
                                    (context, url) => Container(
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withAlpha(100),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maid?.name ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    maid?.address ?? "",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "${maid?.age ?? ""} | ${maid?.gender ?? ""}",
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  SizedBox(height: 6),
                                  Wrap(
                                    spacing: 6,
                                    runSpacing: -8,
                                    children: [
                                      Chip(
                                        label: Text(maid?.workExperience ?? ""),
                                        backgroundColor: Colors.deepPurple[50],
                                        labelStyle: TextStyle(
                                          color:
                                              Theme.of(
                                                context,
                                              ).colorScheme.primary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ContactUsPage(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'HIRE ME',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }
}
