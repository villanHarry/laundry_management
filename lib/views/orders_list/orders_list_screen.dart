import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/product_card.dart';

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
                    child: ProductCard.heading("No Orders Found!",
                        fontSize: 24.sp),
                  )
                  // ListView(
                  //     padding: EdgeInsets.zero,
                  //     children: [for (int i = 0; i < 10; i++) ProductCard()])
                  //
                  ,
                ),
              ],
            ),
          ),
        ));
  }
}
