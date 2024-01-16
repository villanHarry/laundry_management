import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key, required this.status});

  final String status;

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
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
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
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
                      const Spacer(),
                      Text(
                        "${widget.status} ${AppStrings.orders}",
                        style: AppTextStyle.boldTextStyle(
                            fontSize: 21.sp, fgColor: Colors.black),
                      ),
                      const Spacer(),
                      30.horizontalSpace
                    ])),
                23.verticalSpace,
                Container(
                  width: .9.sw,
                  height: .8.sh,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child:
                      //
                      Center(
                    child: heading("No Orders Found!", fontSize: 24.sp),
                  )
                  // ListView(
                  //     padding: EdgeInsets.zero,
                  //     children: [for (int i = 0; i < 10; i++) entry()])
                  //
                  ,
                ),
              ],
            ),
          ),
        ));
  }

  Widget entry({String title = "", String address = ""}) => Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(children: [
                heading("Title"),
                const Spacer(),
                value("10 PKR")
              ]),
              5.verticalSpace,
              Row(children: [
                SizedBox(width: 150.w, child: value("Address")),
                const Spacer(),
                value("queue", align: TextAlign.end)
              ]),
            ],
          ),
        ),
      );

  Widget heading(String heading, {double? fontSize}) => Text(heading,
      textAlign: TextAlign.start,
      style: AppTextStyle.boldTextStyle(
          fgColor: Colors.black,
          fontSize: fontSize ?? 16.sp,
          overflow: TextOverflow.ellipsis));

  Widget value(String value, {align = TextAlign.start}) => Text(value,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.regularTextStyle(
          fgColor: Colors.black, fontSize: 16.sp));
}
