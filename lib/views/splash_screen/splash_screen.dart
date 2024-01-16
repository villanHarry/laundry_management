import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_assets.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/views/getting_started/getting_started.dart';
import 'package:laundry_management/views/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      AppNavigation.push(const GettingStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.darkMode,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          body: Center(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Image.asset(AppAssets.logo,
                      fit: BoxFit.fitHeight, height: 95.h)),
              15.verticalSpace,
              Text(
                AppStrings.title.toUpperCase().replaceAll(" ", "\n"),
                textAlign: TextAlign.center,
                style: AppTextStyle.boldTextStyle(fontSize: 22.sp, height: 1.5),
              )
            ],
          )),
        ));
  }
}
