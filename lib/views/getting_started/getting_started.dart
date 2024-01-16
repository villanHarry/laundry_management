import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/views/login_screen/login_screen.dart';
import 'package:laundry_management/widgets/custom_button.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({super.key});

  @override
  State<GettingStarted> createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
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
                50.verticalSpace,
                Text(AppStrings.loginHeading.toUpperCase(),
                    style: AppTextStyle.boldTextStyle(fontSize: 45.sp)),
                25.verticalSpace,
                Text(
                  AppStrings.title_1.toUpperCase(),
                  style: AppTextStyle.boldTextStyle(),
                ),
                25.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 90.w),
                  child: CustomButton(
                    onPress: () {
                      AppNavigation.push(const LoginScreen());
                    },
                    text: AppStrings.enter.toUpperCase(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
