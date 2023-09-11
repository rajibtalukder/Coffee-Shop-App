import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/controller/auth_controller.dart';
import 'package:spaces_coffee/view/authentication/signin_screen.dart';
import 'package:spaces_coffee/view/authentication/widgets/custom_text_field.dart';
import 'package:spaces_coffee/view/custom_bottom_nav.dart';
import 'package:spaces_coffee/view/global_widgets/texts.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/font_constants.dart';
import '../../utils/utils.dart';
import '../global_widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = Get.find();
  bool isAgreed = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create an Account'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: 728.h,
        width: 390.w,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(height: 40.h),
              titleText("Enter your details to Sign Up to your user account",
                  fontWeight: FontWeight.w600),
              SizedBox(height: 32.h),
              Column(
                children: [
                  customTextField(nameController, "User name",
                      icon: Icons.textsms_outlined),
                  SizedBox(height: 16.h),
                  customTextField(
                    phoneController,
                    "Phone Number",
                    icon: Icons.call,
                  ),
                  SizedBox(height: 16.h),
                  customTextField(
                    emailController,
                    "Email",
                    icon: Icons.email_outlined,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 25.w),
                      child: Text(
                        "Optional Field",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  customTextField(passController, "Password",
                      icon: Icons.lock_outline),
                  SizedBox(height: 16.h),
                  customTextField(
                    confirmPassController,
                    "Confirm Password",
                    icon: Icons.lock,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                      value: isAgreed,
                      onChanged: (checked) {
                        setState(() {
                          isAgreed = checked ?? false;
                        });
                      }),
                  Text(
                    "I have agreed to ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: primaryTextColor,
                    ),
                  ),
                  Text(
                    "Term and condition",
                    style: TextStyle(
                      fontSize: fontVerySmall,
                      fontWeight: FontWeight.w700,
                      color: primaryTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () async {
                  if (nameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      passController.text.isNotEmpty &&
                      confirmPassController.text.isNotEmpty) {
                    await _authController
                        .signUp(
                            nameController.text,
                            emailController.text,
                            phoneController.text,
                            passController.text,
                            confirmPassController.text)
                        .then((value) {
                      if (value) {
                        _authController.getAuthenticatedUser();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const CustomBottomNav()));
                      }
                    });
                  } else {
                    Utils.showSnackBar('Input field is empty...!');
                  }
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: customButton(text: "Sign in", fontcolor: white),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already Member?  ",
                    style: TextStyle(
                      fontSize: fontVerySmall,
                      fontWeight: FontWeight.w500,
                      color: primaryTextColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const SigninScreen()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: fontVerySmall,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
