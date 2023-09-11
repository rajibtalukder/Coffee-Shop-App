import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/constants/colors.dart';
import 'package:spaces_coffee/view/custom_bottom_nav.dart';
import '../../constants/constants.dart';
import '../authentication/signin_screen.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/texts.dart';

class SplashNextScreen extends StatelessWidget {
  const SplashNextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 812.h,
            width: double.infinity,
            child: Image.asset('assets/images/nextsplash_bg.png',
                fit: BoxFit.cover),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 530.h,
                  child: Image.asset('assets/images/nextsplash_coffee.png',
                      fit: BoxFit.cover),
                ),
                titleText(
                  'Leave some \nSpace for Coffee',
                  size: 32,
                  color: whiteLight,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                    onTap: () {
                      if(token.isEmpty){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const SigninScreen()));
                      }else{
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const CustomBottomNav()));
                      }

                    },
                    child: customButton(
                        text: 'ORDER NOW',
                        color: white,
                        width: 240.w,
                        height: 54.h))
              ],
            ),
          )
        ],
      ),
    );
  }
}
