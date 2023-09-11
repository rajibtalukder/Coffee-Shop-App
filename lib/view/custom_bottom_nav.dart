import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spaces_coffee/view/basket/basket_screen.dart';
import 'package:spaces_coffee/constants/colors.dart';
import 'package:spaces_coffee/view/home/home_screen.dart';
import 'package:spaces_coffee/view/profile/profile_screen.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;
  final List _pages = [
    HomeScreen(),
     const BasketScreen(),
     const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Alert'),
                content: const Text('Do you want to Exit?'),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  SizedBox(width: 5.w),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Exit'),
                  ),
                ],
              );
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: whiteLight,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: black,
          showUnselectedLabels: false,
          selectedItemColor: navColor,
          unselectedItemColor: white,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                    height: 20.h,
                    width: 21.w,
                    child: Image.asset('assets/images/homeicon.png',
                        fit: BoxFit.contain, color: white)),
                activeIcon: SizedBox(
                    height: 20.h,
                    width: 21.w,
                    child: Image.asset('assets/images/homeicon.png',
                        fit: BoxFit.contain, color: navColor)),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: SizedBox(
                  height: 20.h,
                  width: 21.w,
                  child: Image.asset('assets/images/carticon.png',
                      fit: BoxFit.contain, color: white),
                ),
                activeIcon: SizedBox(
                  height: 20.h,
                  width: 21.w,
                  child: Image.asset('assets/images/carticon.png',
                      fit: BoxFit.contain, color: navColor),
                ),
                label: 'Basket'),
            BottomNavigationBarItem(
                icon: SizedBox(
                  height: 20.h,
                  width: 21.w,
                  child: Image.asset('assets/images/usericon.png',
                      fit: BoxFit.contain, color: white),
                ),
                activeIcon: SizedBox(
                  height: 20.h,
                  width: 21.w,
                  child: Image.asset('assets/images/usericon.png',
                      fit: BoxFit.contain, color: navColor),
                ),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
