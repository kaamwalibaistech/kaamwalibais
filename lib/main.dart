import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kaamwaalibais/Navigation_folder/navigation_screen.dart';
import 'package:kaamwaalibais/providers/reviewpage_provider.dart';
import 'package:kaamwaalibais/utils/font.dart';
import 'package:kaamwaalibais/utils/local_storage.dart';
import 'package:provider/provider.dart';

import 'providers/homepage_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await LocalStoragePref.instance?.initPrefBox();
  });

  // WidgetsFlutterBinding.ensureInitialized();

  // SchedulerBinding.instance.addTimingsCallback((timings) {
  //   for (var t in timings) {
  //     print("Build: ${t.buildDuration}, Raster: ${t.rasterDuration}");
  //   }
  // });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomepageProvider()),
        ChangeNotifierProvider(create: (_) => ReviewpageProvider()),
      ],
      child: const MyApp(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.light
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = createTextTheme(context, "Poppins", "Poppins");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kaamwalibais',
      theme: ThemeData(
        textTheme: textTheme,
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xff7400b9),
          seedColor: const Color(0xff7400b9),
        ),
      ),
      home: const NavigationScreen(),
      builder: EasyLoading.init(),
    );
  }
}
