import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/controller/auth_controller.dart';
import 'package:spaces_coffee/view/authentication/signup_screen.dart';
import 'package:spaces_coffee/view/authentication/widgets/custom_text_field.dart';
import 'package:spaces_coffee/view/authentication/widgets/outline_button.dart';
import 'package:spaces_coffee/view/global_widgets/texts.dart';
import '../../constants/colors.dart';
import '../../constants/font_constants.dart';
import '../../utils/utils.dart';
import '../custom_bottom_nav.dart';
import '../global_widgets/custom_button.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthController _authController = Get.put(AuthController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: pro.logInScaffoldKey,
      appBar: AppBar(
        title: const Text('User Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 728.h,
          width: 390.w,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45.h),
                const Spacer(),
                titleText("Enter your details to sign in to your user account",
                    fontWeight: FontWeight.w600),
                SizedBox(height: 48.h),
                Column(
                  children: [
                    customTextField(emailController, "Enter Email/ Phone No",
                        icon: Icons.email_outlined),
                    SizedBox(height: 22.h),
                    customTextField(passwordController, "Password",
                        obscureText: true, icon: Icons.lock),
                  ],
                ),
                SizedBox(height: 48.h),
                InkWell(
                  onTap: () async {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      _authController
                          .login(emailController.text, passwordController.text)
                          .then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const CustomBottomNav()));
                        }
                      });
                      emailController.clear();
                      passwordController.clear();
                    } else {
                      Utils.showSnackBar('Input field is empty...!');
                      // _authController
                      //     .login('user@gmail.com', '12345678')
                      //     .then((value) {
                      //   if (value) {
                      //     Navigator.of(context).pushReplacement(
                      //         MaterialPageRoute(
                      //             builder: (_) => const CustomBottomNav()));
                      //   }
                      // });
                      // emailController.clear();
                      // passwordController.clear();
                    }
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: customButton(text: "Login", fontcolor: white),
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "—  or sign in with  —",
                    style: secondaryTextStyle(
                      fontVerySmall,
                      primaryTextColor,
                      FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    outlineButton(logoName: "facebook.png", text: "Facebook"),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {},
                      child:
                          outlineButton(logoName: "google.png", text: "Google"),
                    )
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor,
                        ),
                      ),
                    ),
                    Container(
                      height: 12.h,
                      width: 1.w,
                      color: Colors.black,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SignupScreen()));
                      },
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
