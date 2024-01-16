import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/views/orders_list/orders_list_screen.dart';

class YourOrderScreen extends StatefulWidget {
  const YourOrderScreen({super.key});

  @override
  State<YourOrderScreen> createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.lightMode,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(40))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppNavigation.pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Constants.backgroundColor,
                          size: 30.r,
                        ),
                      ),
                      15.horizontalSpace,
                      Container(
                        width: 50.r,
                        height: 50.r,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Constants.backgroundColor),
                      ),
                      10.horizontalSpace,
                      Text(
                        "${"smkz75@gmail.com"}",
                        style: AppTextStyle.boldTextStyle(
                            fontSize: 21.sp, fgColor: Colors.black),
                      )
                    ],
                  ),
                ),
                50.verticalSpace,
                Container(
                  width: .9.sw,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 40.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(children: [
                    filters(AppStrings.queue),
                    filters(AppStrings.washing),
                    filters(AppStrings.being_washed),
                    filters(AppStrings.being_prepared),
                    filters(AppStrings.done),
                  ]),
                ),
                15.verticalSpace,
              ],
            ),
          ),
        ));
  }

  Widget filters(String value) => GestureDetector(
        onTap: () {
          AppNavigation.push(OrdersListScreen(status: value));
        },
        child: Container(
          width: .5.sw,
          decoration: const BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Text(value.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyle.boldTextStyle(
                  fgColor: Colors.black, fontSize: 20.sp)),
        ),
      );
}
