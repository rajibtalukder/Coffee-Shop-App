import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';


Widget topTextField(IconData icon, TextEditingController controller,{Color?bgcolor,String?hintText, bool edit =false}){
 return  Container(
     height: 50.h,
     width: 335.w,
     decoration: BoxDecoration(
       color:bgcolor?? primaryColor,
       borderRadius: BorderRadius.circular(10.sp),
     ),
     child: Row(
       children: [
         SizedBox(width: 10.w),
         Icon(icon,color: white),
         SizedBox(
           width: 250.w,
           height: 40.h,
           child: TextField(
             controller: TextEditingController(),
             style: const TextStyle(color: white),
             decoration: InputDecoration(
                 hintText: hintText??'Search items',
                 hintStyle: TextStyle(color: white,fontSize: 12.sp),
                 border: const OutlineInputBorder(
                   borderSide: BorderSide.none, // This removes the border
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                 )
             ),
           ),
         ),
         edit==true?SizedBox(
           width: 50.w,
           child: Text('Edit',style: TextStyle(color: white,fontSize: 12.sp)),
         ):const SizedBox(),
       ],
     ),);
}