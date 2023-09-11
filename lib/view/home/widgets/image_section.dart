import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/controller/home_controller.dart';
import 'package:spaces_coffee/model/food_menu_model.dart';

import '../../../constants/colors.dart';
import '../../global_widgets/texts.dart';

class ImageSection extends StatelessWidget {
  final FoodsDatum foodsDatum;
  const ImageSection({
    super.key,
    required this.foodsDatum,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Stack(
      children: [
        Container(
          height: 187.h,
          width: 335.w,
          decoration: BoxDecoration(
            color: black,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            child: Opacity(
              opacity: 0.7,
              child: Image.network(foodsDatum.image??'',
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          top: 13.h,
          left: 12.w,
          child: SizedBox(
            //height: 160.h,
            width: 310.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 32.48.h,
                    width: 32.48.w,
                    decoration: BoxDecoration(
                        color: black,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10.r))),
                    child: const Icon(Icons.close, color: white),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: titleText(foodsDatum.name??'',color: white,
                              size: 32, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 200.w,
                          child: titleText(foodsDatum.description??'',
                              size: 16,color: white,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    Container(
                      height: 42.h,
                      width: 98.w,
                      padding: EdgeInsets.all(10.h),
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.all(Radius.circular(10.r))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                          onTap:(){
                            homeController.decrease();
                            homeController.update(['qntUpdate']);
                          },
                            child: Container(
                              height: 23.88.h,
                              width: 23.88.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                color: white,
                              ),
                              child: const Icon(Icons.remove),
                            ),
                          ),
                          GetBuilder<HomeController>(
                            id: 'qntUpdate',
                            builder: (context) {
                              return titleText(homeController.itemQuantity.value.toString(),color: white,fontWeight: FontWeight.w500,size: 20);
                            }
                          ),
                          GestureDetector(
                            onTap:(){
                              homeController.increase();
                              homeController.update(['qntUpdate']);
                            },
                            child: Container(
                              height: 23.88.h,
                              width: 23.88.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                color: white,
                              ),
                              child: const Icon(Icons.add),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}