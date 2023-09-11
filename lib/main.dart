import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaces_coffee/services/local/shared_pref.dart';
import 'package:spaces_coffee/view/splash/splash_screen.dart';

import 'constants/colors.dart';
import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await SharedPref().getValue('token') ?? '';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(Brightness.light),
        home: const SplashScreen(),
      );
    });
  }
}
ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primarySwatch: primarySwatch,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.outfitTextTheme(baseTheme.textTheme),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
  );
}
