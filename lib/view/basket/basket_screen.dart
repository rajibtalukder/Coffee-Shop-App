import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/constants/colors.dart';
import 'package:spaces_coffee/controller/cart_controller.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/utils/utils.dart';
import '../global_widgets/texts.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50.h,
                    width: 162.5.w,
                    decoration: BoxDecoration(
                      color: black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: subTitleText('Drop-Off (£1.50)',
                          size: 12, color: white),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 162.5.w,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r))),
                    child: Center(
                      child: subTitleText('Collection', size: 12, color: black),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 15.h),
              // topTextField(Icons.location_on_outlined, TextEditingController(),
              //     bgcolor: black,
              //     edit: true,
              //     hintText: '25 Cabot Sq, Floor 14, 14.26'),
              SizedBox(height: 15.h),
              Container(
                height: 250.h,
                width: 335.w,
                decoration: BoxDecoration(
                  color: white.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                ),
                child:
                    /*cartController.isLoading != true
                    ? Center(child: CircularProgressIndicator())
                    : */
                    GetBuilder<CartController>(
                        id: 'cartItemUpdate',
                        builder: (context) {
                          return SingleChildScrollView(
                            child: cartController.localCartItems.length < 1
                                ? Center(child: titleText('Empty Cart'))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10.0.h),
                                        child: titleText('Items in My Order',
                                            size: 16,
                                            color: black,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const Divider(color: black, thickness: 1),
                                      Column(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  cartController
                                                      .localCartItems.length;
                                              i++)
                                            Dismissible(
                                              onDismissed: (val) {
                                                cartController
                                                    .removeItemAtIndex(i);
                                                cartController.localCartItems
                                                    .removeAt(i);
                                              },
                                              key: ValueKey(i),
                                              background: Container(
                                                color: red,
                                                child: const Icon(Icons.delete,
                                                    color: white),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    subTitleText("${i + 1}",
                                                        size: 16,
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    SizedBox(
                                                      width: 120.w,
                                                      child: subTitleText(
                                                          cartController
                                                              .localCartItems[i]
                                                              .slug
                                                              .toString(),
                                                          size: 16,
                                                          color: black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      width: 70.w,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              height: 20.h,
                                                              width: 20.w,
                                                              decoration: BoxDecoration(
                                                                  color: black,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.r))),
                                                              child: const Icon(
                                                                Icons.add,
                                                                size: 16,
                                                                color: white,
                                                              )),
                                                          SizedBox(width: 8.w),
                                                          subTitleText(
                                                              cartController
                                                                  .localCartItems[
                                                                      i]
                                                                  .quantity
                                                                  .toString(),
                                                              color: black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              size: 18),
                                                          SizedBox(width: 8.w),
                                                          Container(
                                                              height: 20.h,
                                                              width: 20.w,
                                                              decoration: BoxDecoration(
                                                                  color: black,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5.r))),
                                                              child: const Icon(
                                                                Icons.remove,
                                                                size: 16,
                                                                color: white,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    subTitleText(
                                                        cartController
                                                            .localCartItems[i]
                                                            .price
                                                            .toString(),
                                                        size: 16,
                                                        color: black,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                          );
                        }),
              ),
              SizedBox(height: 15.h),
              Container(
                //height: 66.h,
                width: 335.w,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 7.h),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        subTitleText(
                          'This Order will earn you 1 stamp!',
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                        subTitleText(
                            'You now have 6 loyalty stamps. \nEarn 3 more for a free hot drink!',
                            color: primaryColor,
                            fontWeight: FontWeight.w300)
                      ],
                    ),
                    SizedBox(
                        height: 36.h,
                        width: 36.w,
                        child: Image.asset(
                          'assets/images/stamp.png',
                          fit: BoxFit.contain,
                        ))
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 90.w),
                height: 66.h,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Container(
                    height: 40.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
                    child: Image.asset(
                      'assets/images/stripe.png',
                      fit: BoxFit.contain,
                    )),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  height: 46.h,
                  width: 335.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.r))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      subTitleText('Order Total',
                          size: 16, fontWeight: FontWeight.w700, color: white),
                      subTitleText('£14.80',
                          size: 16, fontWeight: FontWeight.w700, color: white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                height: 50.h,
                width: 335.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: black,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    const Icon(Icons.arrow_forward_ios, color: white, size: 16),
                    subTitleText('Slide to Pay & Confirm Order',
                        size: 16, fontWeight: FontWeight.w700, color: white),
                    const Icon(Icons.arrow_forward_ios, color: white, size: 16),
                    const SizedBox(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
