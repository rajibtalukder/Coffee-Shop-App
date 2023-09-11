import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors.dart';
import '../../../constants/font_constants.dart';

Widget customTextField(TextEditingController controller, String text,
    {IconData? icon,
      bool obscureText = false,
      bool? isValid,
      bool? isKeyboardPhone,
      Color? bgColor,
      String? errorText}) {
  return Column(
    children: [
      TextField(
        controller: controller,
        keyboardType:isKeyboardPhone==true? TextInputType.phone: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          hintText: text,
          fillColor: bgColor?? Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 18.h,horizontal: 0.w),
          hintStyle: TextStyle(
            color: secondaryDarkTextColor,
            fontSize: fontSmall,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
              ],
            ),
          ),
        ),
        style:  const TextStyle(
          height: 1,
        ),
      ),
      if (isValid != null && !isValid)
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.w),
            child: Text(
              errorText ?? "",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: red,
              ),
            ),
          ),
        ),
    ],
  );
}