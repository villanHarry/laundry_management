import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/utils/firebaseServices.dart';
import 'package:laundry_management/views/getting_started/getting_started.dart';
import 'package:laundry_management/views/print_screen/print_screen.dart';
import 'package:laundry_management/views/your_orders_screen/your_orders_screen.dart';
import 'package:laundry_management/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.admin = false});

  final bool admin;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropDOwnValue = AppStrings.queue;
  bool loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      log(auth!.currentUser.toString());
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.lightMode,
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: 1.sh,
              child: Scaffold(
                // floatingActionButtonLocation:
                //     FloatingActionButtonLocation.centerDocked,
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () {},
                //   backgroundColor: Colors.white,
                //   shape: const CircleBorder(),
                //   child: Constants.bottomIcons(Icons.add),
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
                    //           label: "", icon: Constants.bottomIcons(Icons.list)),
                    //       BottomNavigationBarItem(
                    //           label: "", icon: Constants.bottomIcons(Icons.print))
                    //     ]),
                    widget.admin
                        ? null
                        : Container(
                            padding: EdgeInsets.all(25.r),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      AppNavigation.push(
                                          const YourOrderScreen());
                                    },
                                    child: Constants.bottomIcons(Icons.list)),
                                SizedBox(
                                    height: .04.sh,
                                    child: const VerticalDivider()),
                                GestureDetector(
                                    onTap: () {
                                      AppNavigation.push(const PrintScreen());
                                    },
                                    child: Constants.bottomIcons(Icons.print))
                              ],
                            ),
                          ),
                backgroundColor: Constants.backgroundColor,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 30.h),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(40))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            8.verticalSpace,
                            Row(children: [
                              const Spacer(),
                              Text(
                                AppStrings.title_1.toUpperCase(),
                                style: AppTextStyle.boldTextStyle(
                                    fontSize: 20.sp,
                                    fgColor: Constants.backgroundColor),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  await FirebaseServices.logout();
                                  setState(() {
                                    loading = false;
                                  });
                                  AppNavigation.popallStack(
                                      const GettingStarted());
                                },
                                child: Constants.bottomIcons(
                                    Icons.power_settings_new_rounded,
                                    size: 30.r),
                              )
                            ]),
                            8.verticalSpace,
                            // Row(children: [
                            //   const Spacer(),
                            //   Text(
                            //     AppStrings.title.toUpperCase(),
                            //     style: AppTextStyle.boldTextStyle(
                            //         fontSize: 20.sp,
                            //         fgColor: Constants.backgroundColor),
                            //   ),
                            //   const Spacer(),
                            // ]),
                          ],
                        ),
                      ),
                      30.verticalSpace,
                      widget.admin ? adminBody() : body(),
                      15.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: loading,
              child: Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget adminBody() {
    return Container(
      width: .9.sw,
      height: .75.sh,
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: dropDownMenu(),
          ),
          //
          Expanded(
            child:
                //
                //     Center(
                //   child: ProductCard.heading("No Orders Found!", fontSize: 24.sp),
                // )
                ListView(padding: EdgeInsets.zero, children: [
              for (int i = 0; i < 10; i++) ProductCard(admin: widget.admin)
            ]),
          ),
        ],
      ),
    );
  }

  Widget dropDownMenu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Constants.bottomIcons(Icons.filter_alt, size: 30.r),
        12.horizontalSpace,
        Expanded(
          child: DropdownButtonFormField<String>(
              padding: EdgeInsets.zero,
              enableFeedback: false,
              alignment: Alignment.centerLeft,
              decoration: InputDecoration(
                  enabled: false,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.1, color: Colors.black),
                      borderRadius: BorderRadius.circular(10))),
              value: dropDOwnValue,
              style: AppTextStyle.regularTextStyle(
                  fgColor: Colors.black, fontSize: 17.sp),
              borderRadius: BorderRadius.circular(10),
              items: ProductStatus.values
                  .map((e) => DropdownMenuItem<String>(
                      value: statusView[e],
                      child: ProductCard.value(statusView[e] ?? "",
                          align: TextAlign.end)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    dropDOwnValue = value;
                  });
                }
              }),
        ),
      ],
    );
  }

  Widget body() {
    return Container(
      width: .9.sw,
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(40)),
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
    );
  }

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
