import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/views/print_screen/print_screen.dart';
import 'package:laundry_management/views/your_orders_screen/your_orders_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.lightMode,
        child: Scaffold(
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
          //   backgroundColor: Colors.white,
          //   shape: const CircleBorder(),
          //   child: bottomIcons(Icons.add),
          // ),
          bottomNavigationBar:
              //
              // BottomNavigationBar(
              //     onTap: (index) {
              //       switch (index) {
              //         case 0:
              //           AppNavigation.push(const YourOrderScreen());
              //           break;
              //       }
              //     },
              //     backgroundColor: Colors.white,
              //     items: [
              //       BottomNavigationBarItem(
              //           label: "", icon: bottomIcons(Icons.list)),
              //       BottomNavigationBarItem(
              //           label: "", icon: bottomIcons(Icons.print))
              //     ]),
              Container(
            padding: EdgeInsets.all(25.r),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                    onTap: () {
                      AppNavigation.push(const YourOrderScreen());
                    },
                    child: bottomIcons(Icons.list)),
                SizedBox(height: .04.sh, child: const VerticalDivider()),
                GestureDetector(
                    onTap: () {
                      AppNavigation.push(const PrintScreen());
                    },
                    child: bottomIcons(Icons.print))
              ],
            ),
          ),
          backgroundColor: Constants.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(40))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        const Spacer(),
                        Text(
                          AppStrings.loginHeading.toUpperCase(),
                          style: AppTextStyle.boldTextStyle(
                              fontSize: 20.sp,
                              fgColor: Constants.backgroundColor),
                        ),
                        const Spacer(),
                      ]),
                      8.verticalSpace,
                      Row(children: [
                        const Spacer(),
                        Text(
                          AppStrings.title.toUpperCase(),
                          style: AppTextStyle.boldTextStyle(
                              fontSize: 20.sp,
                              fgColor: Constants.backgroundColor),
                        ),
                        const Spacer(),
                      ]),
                    ],
                  ),
                ),
                30.verticalSpace,
                Container(
                  width: .9.sw,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(children: [
                    30.verticalSpace,
                    Text("${AppStrings.today.toUpperCase()}: ${0}",
                        style: AppTextStyle.boldTextStyle(
                            fgColor: Colors.black, fontSize: 24.sp)),
                    50.verticalSpace,
                    Text(AppStrings.no_of_orders.toUpperCase(),
                        style: AppTextStyle.boldTextStyle(
                            fgColor: Colors.black, fontSize: 20.sp)),
                    values(0),
                    Text(AppStrings.queue.toUpperCase(),
                        style: AppTextStyle.boldTextStyle(
                            fgColor: Colors.black, fontSize: 20.sp)),
                    values(0),
                    Text(AppStrings.done.toUpperCase(),
                        style: AppTextStyle.boldTextStyle(
                            fgColor: Colors.black, fontSize: 20.sp)),
                    values(0),
                    30.verticalSpace
                  ]),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ));
  }

  Icon bottomIcons(IconData icon) => Icon(
        icon,
        size: 35.r,
        color: Constants.backgroundColor,
      );

  Widget values(int value) => Container(
        margin: EdgeInsets.symmetric(vertical: 30.h),
        width: .5.sw,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
        child: Text("$value",
            textAlign: TextAlign.center,
            style: AppTextStyle.boldTextStyle(
                fgColor: Colors.grey, fontSize: 20.sp)),
      );
}
