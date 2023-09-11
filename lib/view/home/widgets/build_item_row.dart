import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/colors.dart';
import '../../global_widgets/texts.dart';

Widget buildItemRow({bool reverseOrder = false}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    child: Row(
      children: [
        SizedBox(width: 20.w,),
        if (!reverseOrder)
          smallTextCard('Small', textColor: white, bgColor: black),
        if (!reverseOrder) SizedBox(width: 10.w),
        smallTextCard('Regular(50p)'),
        SizedBox(width: 10.w),
        smallTextCard('Large(50p)'),
        SizedBox(width: 10.w),
        if (reverseOrder) smallTextCard('Large(50p)'),
      ],
    ),
  );
}
Widget smallTextCard(String text, {Color? textColor, Color? bgColor}) {
  return Container(
    height: 32.5.h,
    width: 137.w,
    decoration: BoxDecoration(
        border: Border.all(color: black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: bgColor ?? white.withOpacity(0.5)),
    child: Center(
      child: titleText(text,
          color: textColor ?? black, size: 12, fontWeight: FontWeight.w400),
    ),
  );
}