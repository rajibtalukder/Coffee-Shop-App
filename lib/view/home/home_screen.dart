import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spaces_coffee/controller/home_controller.dart';
import 'package:spaces_coffee/view/global_widgets/custom_button.dart';
import 'package:spaces_coffee/view/home/home_category.dart';

import '../../constants/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 50.h,
                  width: 335.w,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10.w),
                      const Icon(Icons.search, color: white),
                      SizedBox(
                        width: 250.w,
                        height: 40.h,
                        child: TextField(
                          onChanged: (val) async {
                            homeController.onSearch(val.toLowerCase());
                          },
                          controller: _searchController,
                          style: const TextStyle(color: white),
                          decoration: InputDecoration(
                              hintText: 'Search items',
                              hintStyle:
                                  TextStyle(color: white, fontSize: 12.sp),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              )),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 20.h),
              GetBuilder<HomeController>(
                  id: 'gridUpdate',
                  builder: (context) {
                    return SizedBox(
                      height: 630.h,
                      child: homeController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                              ),
                              itemCount: homeController
                                      .filteredFoodMenu.value.data?.length ??
                                  0,
                              // Number of items in the grid
                              itemBuilder: (BuildContext context, int index) {
                                if (index ==
                                        homeController.filteredFoodMenu.value
                                                .data!.length -
                                            1 &&
                                    homeController.haveMoreMenu.value) {
                                  homeController.loadMoreData();
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (_) => HomeCategory(
                                        selectedIndex: index,
                                        foods: homeController.filteredFoodMenu
                                            .value.data?[index].foods,
                                      ),
                                    ));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 220.h,
                                        width: 158.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.r),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10.r),
                                          ),
                                          child: Image.network(
                                            homeController.filteredFoodMenu
                                                .value.data![index].image
                                                .toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 15.h,
                                        left: 10.w,
                                        right: 15.w,
                                        child: customButton(
                                          text: homeController.filteredFoodMenu
                                              .value.data![index].name
                                              .toString(),
                                          fontSize: 16,
                                          color: Colors.white,
                                          width: 138,
                                          height: 34,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                    );
                  }),
              SizedBox(height: 300.h),
            ],
          ),
        ),
      ),
    );
  }
}
