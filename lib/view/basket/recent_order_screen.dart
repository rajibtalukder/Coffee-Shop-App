import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/controller/profile_controller.dart';
import 'package:spaces_coffee/view/global_widgets/custom_button.dart';
import 'package:spaces_coffee/view/global_widgets/texts.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/view/profile/order_details.dart';
import '../../constants/colors.dart';
import '../../constants/font_constants.dart';

class ResentOrderScreen extends StatelessWidget {
  const ResentOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    final List<int> steps = [1, 2, 3, 4];
    profileController.selectedStepChange();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
              height: 100.h,
              color: whiteLight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20.h),
                      subTitleText('ESTIMATED TIME',
                          color: Colors.grey, size: 16.sp),
                      subTitleText('30 minutes', color: black, size: 16.sp),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20.h),
                      subTitleText('ORDER NUMBER',
                          color: Colors.grey, size: 16.sp),
                      subTitleText('#2482011', color: black, size: 16.sp),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.w),
                height: 300.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 290.h,
                      child: const VerticalDivider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var step in steps)
                          Icon(
                            Icons.circle,
                            color: step == profileController.selectedStep.value
                                ? primaryColor
                                : Colors.grey,
                            size: step == profileController.selectedStep.value
                                ? 24.0
                                : 16.0,
                          )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 340.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 60.w,
                          child: Image.asset('assets/images/placed.gif'),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subTitleText('Order Placed',
                                size: 14,
                                color: profileController.selectedStep.value == 1
                                    ? primaryColor
                                    : black),
                            subTitleText('We have received your data',
                                size: 12,
                                color: profileController.selectedStep.value == 1
                                    ? primaryColor
                                    : black.withOpacity(0.6)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 60.w,
                          child: Image.asset('assets/images/confirm.gif'),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subTitleText('Order Confirmed',
                                size: 14,
                                color: profileController.selectedStep.value == 2
                                    ? primaryColor
                                    : black),
                            subTitleText('Your order has been confirmed',
                                size: 12,
                                color: profileController.selectedStep.value == 2
                                    ? primaryColor
                                    : black.withOpacity(0.6)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 60.w,
                          child: Image.asset('assets/images/cooking.gif'),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subTitleText('Order Processed',
                                size: 14,
                                color: profileController.selectedStep.value == 3
                                    ? primaryColor
                                    : black),
                            subTitleText('We are preparing your order',
                                size: 12,
                                color: profileController.selectedStep.value == 3
                                    ? primaryColor
                                    : black.withOpacity(0.6)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50.h,
                          width: 60.w,
                          child: Image.asset('assets/images/pickupBox.gif'),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subTitleText('Ready to Pickup',
                                size: 14,
                                color: profileController.selectedStep.value == 4
                                    ? primaryColor
                                    : black),
                            subTitleText('Your order is ready for pickup',
                                size: 12,
                                color: profileController.selectedStep.value == 4
                                    ? primaryColor
                                    : black.withOpacity(0.6)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 50.h),
          Center(
            child: GestureDetector(
              onTap: (){
                Get.to(OrderDetails());
              },
              child: Container(
                height: 40.h,
                width: 200.w,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Center(
                  child: Text(
                    'See More Details',
                    style: TextStyle(
                      fontSize: fontSmall,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
