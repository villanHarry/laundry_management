import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/custom_button.dart';
import 'package:laundry_management/widgets/custom_input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final TextEditingController conf_pass = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.darkMode,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                40.verticalSpace,
                Row(
                  children: [
                    10.horizontalSpace,
                    GestureDetector(
                      onTap: () {
                        AppNavigation.pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 30.r,
                          color: Constants.backgroundColor,
                        ),
                      ),
                    )
                  ],
                ),
                22.verticalSpace,
                Container(
                  width: .9.sw,
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(children: [
                    40.verticalSpace,
                    Text("${AppStrings.signup.toUpperCase()}!",
                        style: AppTextStyle.boldTextStyle(
                            fgColor: Colors.black, fontSize: 22.sp)),
                    50.verticalSpace,
                    CustomInputField(
                        prefix: AppStrings.email.toUpperCase(),
                        hint: AppStrings.email_address,
                        controller: email),
                    35.verticalSpace,
                    CustomInputField(
                        prefix: AppStrings.password.toUpperCase(),
                        hint: AppStrings.password,
                        controller: pass),
                    35.verticalSpace,
                    CustomInputField(
                        prefix: AppStrings.confirm_password
                            .replaceAll(" ", "\n")
                            .toUpperCase(),
                        hint: AppStrings.password,
                        controller: conf_pass),
                    35.verticalSpace,
                    CustomInputField(
                        prefix: AppStrings.address.toUpperCase(),
                        hint: AppStrings.address,
                        controller: address),
                    35.verticalSpace,
                    CustomInputField(
                        prefix: AppStrings.phone.toUpperCase(),
                        hint: AppStrings.phone,
                        controller: phone),
                    35.verticalSpace,
                    SizedBox(
                        width: .5.sw,
                        child: CustomButton(
                            bgColor: Constants.backgroundColor,
                            text: AppStrings.signup.toUpperCase(),
                            fontColor: Colors.white,
                            fontSize: 17.sp)),
                    60.verticalSpace,
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
