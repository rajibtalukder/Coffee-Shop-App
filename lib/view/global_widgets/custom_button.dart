import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/font_constants.dart';

Container customButton({
  double? height,
  double? width,
  required String text,
  double? fontSize,
  Color? color,
  Color? fontcolor,
  String? imageName,
}) {
  return Container(
    height: height ?? 40.h,
    width: width ?? double.infinity,
    decoration: BoxDecoration(
      color: color ?? primaryColor,
      borderRadius: BorderRadius.circular(10.sp),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageName != null)
          SizedBox(
            height: 16.h,
            width: 16.w,
            child: Image.asset(
              "assets/$imageName",
              fit: BoxFit.contain,
            ),
          ),
        if (imageName != null) SizedBox(width: 10.w),
        SizedBox(
          width: 120.w,
          child: Center(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSize ?? fontSmall,
                color: fontcolor??black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

CircleAvatar circleAvatar(IconData iconData , {Color color = primaryColor}) {
  return CircleAvatar(
    backgroundColor: color,
    radius: 12.r,
    child: Icon(
      iconData,
      size: 15.sp,
      color: Colors.white,
    ),
  );
}
