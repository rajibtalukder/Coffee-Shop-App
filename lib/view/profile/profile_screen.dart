import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/controller/profile_controller.dart';
import 'package:spaces_coffee/view/authentication/signin_screen.dart';
import 'package:spaces_coffee/view/profile/edit_profile.dart';
import 'package:spaces_coffee/view/profile/order_details.dart';

import '../../constants/colors.dart';
import '../../constants/font_constants.dart';
import '../../controller/home_controller.dart';
import '../basket/recent_order_screen.dart';
import '../global_widgets/texts.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  HomeController homeController = Get.find();
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GetBuilder<ProfileController>(
          id: 'profileUpdate',
          builder: (ctx) {
            return Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0.w),
              child: profileController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildColumn(context, homeController, profileController),
            );
          }),
    ));
  }

  _buildColumn(BuildContext context, HomeController controller,
      ProfileController profileController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 350.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: 150.h,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                  child: Container(color: primaryColor.withOpacity(0.8)),
                ),
              ),
              Positioned(
                left: 130.w,
                top: 100.h,
                child: GetBuilder<ProfileController>(
                    id: 'imgPathUpdate',
                    builder: (authController) {
                      return Container(
                        height: 100.h,
                        width: 100.h,
                        padding: EdgeInsets.all(5.w),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: white),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: profileController.imagePath == ''
                                ? Image.network(
                                    profileController
                                            .authenticatedUser?.data?.image ??
                                        '',
                                    fit: BoxFit.cover)
                                : Image.file(
                                    File(profileController.imagePath),
                                    fit: BoxFit.cover,
                                  )),
                      );
                    }),
              ),
              Positioned(
                bottom: 60.h,
                child: Column(
                  children: [
                    titleText(
                        '${profileController.authenticatedUser?.data?.firstName.toString()}'
                        ' ${profileController.authenticatedUser?.data?.lastName.toString()}',
                        size: fontMedium,
                        fontWeight: FontWeight.w500,
                        color: primaryTextColor),
                    TextButton(
                      child: titleText('Edit Profile',
                          color: primaryColor, size: fontVerySmall),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const EditProfile()));
                      },
                    ),
                    SizedBox(height: 10.h)
                  ],
                ),
              ),
              Positioned(
                bottom: 50.h,
                child: titleText(
                    'Reward Point : ${profileController.authenticatedUser?.data?.rewardsAvailable}',
                    size: fontSmall,
                    fontWeight: FontWeight.w500,
                    color: secondaryTextColor),
              ),
              Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      profileController.logOut().then((value) {
                        if (value) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const SigninScreen(),
                            ),
                          );
                        }
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.logout, color: white),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 200.h,
          width: 350.w,
          child: GetBuilder<ProfileController>(
              id: 'updateProfile',
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText('Recent Order',
                        size: fontMedium, fontWeight: FontWeight.w600),
                    GestureDetector(
                            onTap: () {
                              profileController.recentOrderData.value.data?.status=='served'?
                              Get.to(OrderDetails()):
                              Get.to(ResentOrderScreen());
                            },
                            child: Container(
                              height: 70.h,
                              margin: EdgeInsets.only(top: 10.h),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                  color: whiteLight,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.r))),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 70.h,
                                    width: 65.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                          profileController
                                                  .recentOrderData
                                                  .value
                                                  .data
                                                  ?.items
                                                  ?.first
                                                  .image ??
                                              '',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  SizedBox(
                                    width: 230.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                  profileController
                                                          .recentOrderData
                                                          .value
                                                          .data
                                                          ?.invoice ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: fontSmall,
                                                    color: primaryTextColor,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                            ),
                                            titleText(
                                              profileController.recentOrderData
                                                      .value.data?.status ??
                                                  '',
                                              size: fontVerySmall,
                                              color: primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            titleText('items',
                                                size: fontVerySmall,
                                                color: secondaryTextColor,
                                                fontWeight: FontWeight.w500),
                                            titleText(
                                              profileController.recentOrderData
                                                      .value.data?.dateTime ??
                                                  '',
                                              size: fontVerySmall,
                                              color: secondaryTextColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    titleText('Order History',
                        size: fontMedium, fontWeight: FontWeight.w600),
                  ],
                );
              }),
        ),
        // Expanded(child: orderHistory(context)),
      ],
    );
  }
}
