import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/controller/cart_controller.dart';
import 'package:spaces_coffee/controller/home_controller.dart';
import 'package:spaces_coffee/model/food_menu_model.dart' as FoodModel;
import 'package:get/get.dart';
import 'package:spaces_coffee/utils/utils.dart';
import 'package:spaces_coffee/view/authentication/widgets/custom_text_field.dart';

import '../../../constants/colors.dart';
import '../../../model/cart_item_model.dart';
import '../../global_widgets/texts.dart';
import 'image_section.dart';

Widget buildBottomSheet(FoodModel.FoodsDatum datum) {
  HomeController homeController = Get.find();
  CartController cartController = Get.put(CartController());

  TextEditingController noteController = TextEditingController();


  return Container(
    color: whiteLight,
    child: Container(
      height: 626.h,
      margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 10.h),
      decoration: BoxDecoration(
          color: white.withOpacity(0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSection(foodsDatum: datum),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child:
                      titleText('Size', size: 16, fontWeight: FontWeight.w500),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      SizedBox(width: 20.w),
                      for (int i = 0; i < datum.variants!.data!.length; i++)
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              if (homeController.sizeSelect == i) {
                                homeController.sizeSelect = -1;
                              } else {
                                homeController.sizeSelect = i;
                              }
                              homeController.update(['selectedSizeUpdate']);
                            },
                            child: GetBuilder<HomeController>(
                                id: 'selectedSizeUpdate',
                                builder: (context) {
                                  return Container(
                                    height: 32.5.h,
                                    width: 137.w,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: black, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)),
                                        color: homeController.sizeSelect == i
                                            ? black
                                            : white.withOpacity(0.5)),
                                    child: Center(
                                      child: titleText(
                                          datum.variants?.data?[i].name.name
                                                  .toString() ??
                                              '',
                                          color: homeController.sizeSelect == i
                                              ? white
                                              : black,
                                          size: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  );
                                }),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < datum.addons!.data!.length; i++)
                      Builder(builder: (context) {
                        //print(datum.addons!.data![i].subAddons!.data!.length);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 8.h),
                              child: titleText(
                                  datum.addons?.data?[i].name ?? '',
                                  size: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: [
                                  SizedBox(width: 20.w),
                                  for (int j = 0;
                                      j <
                                          datum.addons!.data![i].subAddons!
                                              .data!.length;
                                      j++)
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          datum.addons!.data![i].subAddons!
                                                  .data![j].isSelected =
                                              !datum.addons!.data![i].subAddons!
                                                  .data![j].isSelected;

                                          homeController
                                              .update(['selectedAddonsUpdate']);
                                        },
                                        child: GetBuilder<HomeController>(
                                            id: 'selectedAddonsUpdate',
                                            builder: (context) {
                                              return Container(
                                                height: 32.5.h,
                                                width: 137.w,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: black, width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.r)),
                                                    color: datum
                                                            .addons!
                                                            .data![i]
                                                            .subAddons!
                                                            .data![j]
                                                            .isSelected
                                                        ? black
                                                        : white
                                                            .withOpacity(0.5)),
                                                child: Center(
                                                  child: titleText(
                                                      datum
                                                              .addons
                                                              ?.data?[i]
                                                              .subAddons
                                                              ?.data?[j]
                                                              .name
                                                              .toString() ??
                                                          '',
                                                      color: datum
                                                              .addons!
                                                              .data![i]
                                                              .subAddons!
                                                              .data![j]
                                                              .isSelected
                                                          ? white
                                                          : black,
                                                      size: 12,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText('Note', size: 16, fontWeight: FontWeight.w500),
                      SizedBox(height: 10.h),
                      customTextField(
                          noteController, 'Write a note...',
                          bgColor: Colors.transparent),
                    ],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              //height: 90.h,
              width: 335.w,
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
              decoration: BoxDecoration(
                  color: black,
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      titleText('Total:',
                          color: white, fontWeight: FontWeight.w300, size: 20),
                      titleText('£ ${datum.price}',
                          color: white, fontWeight: FontWeight.w700, size: 20)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      final cartItem = CartItemModel(
                          slug: datum.slug,
                          quantity: homeController.itemQuantity.value.toInt(),
                          price: datum.price,
                          note: noteController.text
                      );
                      cartController.addCartItem(cartItem);
                      Utils.showSnackBar('Added Cart');
                    },
                    child: Container(
                        height: 47.5.h,
                        width: 98.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subTitleText('Add to \nBasket',
                                size: 12, color: black),
                            const Icon(
                              Icons.shopping_cart_outlined,
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
