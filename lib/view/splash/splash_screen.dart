import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/view/splash/splash_next_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      splash: SizedBox(
        height: 812.h,
        width: 375.w,
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.fill,
        ),
      ),
      splashIconSize: 1000,
      nextScreen: const SplashNextScreen(),
    );
  }
}
