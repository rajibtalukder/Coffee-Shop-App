import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/controller/home_controller.dart';
import 'package:spaces_coffee/model/food_menu_model.dart';
import 'package:spaces_coffee/view/home/widgets/build_bottom_sheet.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../global_widgets/custom_button.dart';
import '../global_widgets/texts.dart';

class HomeCategory extends StatelessWidget {
  Foods? foods;
  int? selectedIndex;

  HomeCategory({Key? key, required this.foods, required this.selectedIndex})
      : super(key: key);
  HomeController homeController = Get.find();
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    homeController.filteredItems = [];
    foods?.data?.forEach((element) {
      homeController.filteredItems.add(element.clone());
    });
    return Scaffold(
      backgroundColor: whiteLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: ListView(
            physics: const BouncingScrollPhysics(),
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
                            homeController.onSearchItems(
                                val.toLowerCase(), foods);
                          },
                          controller: _searchController,
                          style: const TextStyle(color: white),
                          decoration: InputDecoration(
                              hintText: 'Search Items',
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
              SizedBox(height: 10.h),
              SizedBox(
                height: 55.h,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        homeController.filteredFoodMenu.value.data?.length ?? 0,
                    itemBuilder: (context, child) => GestureDetector(
                          onTap: () {
                            homeController.categorySelect = child;
                            foods = homeController
                                .filteredFoodMenu.value.data![child].foods;
                            homeController.filteredItems = foods!.data!;
                            homeController.update(['categoryUpdate']);
                            homeController.update(['selectItemUpdate']);
                          },
                          child: GetBuilder<HomeController>(
                              id: 'selectItemUpdate',
                              builder: (context) {
                                return Container(
                                  margin:
                                      EdgeInsets.fromLTRB(10.w, 10.h, 0, 10.h),
                                  padding:
                                      EdgeInsets.fromLTRB(5.w, 0.h, 5, 0.h),
                                  height: 34.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      color:
                                          homeController.categorySelect == child
                                              ? primaryColor
                                              : white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r))),
                                  child: Center(
                                    child: subTitleText(
                                        homeController.filteredFoodMenu.value
                                                .data?[child].name ??
                                            '',
                                        color: homeController.categorySelect ==
                                                child
                                            ? white
                                            : black,
                                        fontWeight: FontWeight.w500,
                                        size: 14),
                                  ),
                                );
                              }),
                        )),
              ),
              GetBuilder<HomeController>(
                  id: 'categoryUpdate',
                  builder: (context) {
                    return SizedBox(
                      height: 630.h,
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),

                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        itemCount: homeController.filteredItems.length,
                        // Number of items in the grid
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                      context: context,
                                      builder: (_) => buildBottomSheet(
                                          homeController.filteredItems[index]));
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) => const ProductScreen()));
                                },
                                child: Container(
                                    height: 220.h,
                                    width: 158.w,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)),
                                        child: Image.network(
                                            homeController.filteredItems[index].image ??
                                                '',
                                            fit: BoxFit.cover))),
                              ),
                              Positioned(
                                bottom: 15.h,
                                left: 10.w,
                                right: 15.w,
                                child: customButton(
                                    text: homeController.filteredItems[index].name ??
                                        '',
                                    fontSize: 16,
                                    color: white,
                                    width: 138,
                                    height: 34),
                              )
                            ],
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
