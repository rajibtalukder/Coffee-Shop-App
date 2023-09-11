import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/controller/profile_controller.dart';
import 'package:spaces_coffee/model/cart_item_model.dart';
import 'package:spaces_coffee/view/global_widgets/texts.dart';
import 'package:spaces_coffee/view/profile/widgets/build_custom_row.dart';

import '../../constants/colors.dart';
import '../../constants/font_constants.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        leading: const BackButton(color: primaryTextColor),
        elevation: 0.0,
        title: const Text('Recent Order Details',
            style: TextStyle(color: primaryTextColor)),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCustomRow('Invoice :',
                profileController.recentOrderData.value.data?.invoice ?? ''),
            buildCustomRow('Status :',
                profileController.recentOrderData.value.data?.status ?? ''),
            buildCustomRow('Type :',
                profileController.recentOrderData.value.data?.type ?? ''),
            buildCustomRow(
                'Delivery Type :',
                profileController.recentOrderData.value.data?.deliveryType ??
                    ''),
            buildCustomRow('Grand Total :',
                profileController.recentOrderData.value.data?.grandTotal ?? ''),
            buildCustomRow('Date Time :',
                profileController.recentOrderData.value.data?.dateTime ?? ''),
            buildCustomRow(
                'Running Time :',
                profileController.recentOrderData.value.data?.runningTime ??
                    ''),
            SizedBox(height: 20.h),
            titleText('Address :', size: 14, fontWeight: FontWeight.w600),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  DataTable(
                    border: TableBorder(
                        bottom: BorderSide(color: borderColor, width: 1),
                        left: BorderSide(color: borderColor, width: 1),
                        top: BorderSide(color: borderColor, width: 1),
                        right: BorderSide(color: borderColor, width: 1),
                        horizontalInside:
                        BorderSide(color: borderColor, width: 1),
                        verticalInside:
                        BorderSide(color: borderColor, width: 1)),
                    columns: [
                      DataColumn(
                          label: titleText('Type', size:14,fontWeight: FontWeight.w600)),
                      DataColumn(
                          label: titleText('Location', size: 14,fontWeight: FontWeight.w600)),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(subTitleText(profileController.recentOrderData.value.data?.address?.type??'',
                            size: 14)),
                        DataCell(subTitleText(profileController.recentOrderData.value.data?.address?.location??'',
                            size: 14)),
                      ]),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10.h),
            titleText('Items :', size: 14, fontWeight: FontWeight.w600),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 180.h,
                width: 280.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: whiteLight,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Column(
                  children: [
                    for (int i = 0;
                        i <
                            profileController
                                .recentOrderData.value.data!.items!.length;
                        i++)
                      Container(
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
                                    profileController.recentOrderData.value.data
                                            ?.items?[i].image ??
                                        '',
                                    fit: BoxFit.cover),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  titleText(
                                      profileController.recentOrderData.value
                                              .data?.items?[i].name ??
                                          '',
                                      size: 12,
                                      fontWeight: FontWeight.w500),
                                  subTitleText(
                                      '${profileController.recentOrderData.value.data?.items?[i].quantity}x',
                                      size: 10),
                                  subTitleText(
                                      profileController.recentOrderData.value
                                              .data?.items?[i].variant ??
                                          '',
                                      size: 12),
                                  Row(
                                    children: [],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
