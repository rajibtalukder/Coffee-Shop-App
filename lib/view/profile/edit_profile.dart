import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spaces_coffee/controller/auth_controller.dart';
import 'package:spaces_coffee/controller/home_controller.dart';
import 'package:spaces_coffee/controller/profile_controller.dart';
import 'package:spaces_coffee/view/global_widgets/texts.dart';
import 'package:spaces_coffee/view/profile/widgets/input_field.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../global_widgets/custom_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController fNameCtlr = TextEditingController(
        text: profileController.authenticatedUser?.data?.firstName.toString());
    TextEditingController lNameCtlr = TextEditingController(
        text: profileController.authenticatedUser?.data?.lastName.toString());
    TextEditingController emailCtlr = TextEditingController(
        text: profileController.authenticatedUser?.data?.email.toString());
    TextEditingController phnCtlr = TextEditingController(
        text: profileController.authenticatedUser?.data?.phone.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: const BackButton(color: primaryTextColor),
        elevation: 0.0,
        title: const Text('Edit Profile',
            style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(children: [
                  GetBuilder<HomeController>(
                      id: 'imgPathUpdate',
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.all(5.w),
                          height: 120.h,
                          width: 120.h,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                height: 180.h,
                                child: Center(
                                  child: Container(
                                      height: 170.h,
                                      width: 320.w,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 20.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          titleText('Choose an option',
                                              fontWeight: FontWeight.w600,
                                              size: 18),
                                          SizedBox(height: 10.h),
                                          GestureDetector(
                                            onTap: () {
                                              profileController.pickedImage(
                                                  ImageSource.camera);
                                              Get.back();
                                            },
                                            child: SizedBox(
                                              height: 50.h,
                                              width: 200.w,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.camera_alt),
                                                  SizedBox(width: 10.w),
                                                  subTitleText('Camera',
                                                      size: 16,
                                                      color: primaryTextColor),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              profileController.pickedImage(
                                                  ImageSource.gallery);
                                              Get.back();
                                            },
                                            child: SizedBox(
                                              height: 50.h,
                                              width: 200.w,
                                              child: Row(
                                                children: [
                                                  const Icon(Icons.photo),
                                                  SizedBox(width: 10.w),
                                                  subTitleText('Gallery',
                                                      size: 16,
                                                      color: primaryTextColor),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 42.h,
                        width: 42.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: white,
                        ),
                        padding: EdgeInsets.all(3.w),
                        child: CircleAvatar(
                          radius: 20.r,
                          child: const Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(height: 30.h),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    inputField(
                      'First Name',
                      Icons.person,
                      fNameCtlr,
                    ),
                    inputField(
                      'Last Name',
                      Icons.person,
                      lNameCtlr,
                    ),
                    inputField(
                      'Email',
                      Icons.mail,
                      emailCtlr,
                    ),
                    inputField(
                      'Phone',
                      Icons.call,
                      phnCtlr,
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () async {
                          await profileController.updateUserProfile(fNameCtlr.text,
                              lNameCtlr.text, emailCtlr.text, phnCtlr.text);
                        },
                        child: customButton(
                            text: 'Update Profile', fontcolor: white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectImageOption(BuildContext context) {}
}
