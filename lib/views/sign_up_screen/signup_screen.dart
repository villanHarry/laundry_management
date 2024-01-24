import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/app_validator.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/utils/firebaseServices.dart';
import 'package:laundry_management/views/home_screen/home_screen.dart';
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
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.darkMode,
        child: Stack(
          children: [
            SizedBox(
              width: 1.sw,
              height: 1.sh,
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
                      Form(
                        key: _key,
                        child: Container(
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
                                validator: AppValidator.emailValidator,
                                prefix: AppStrings.email.toUpperCase(),
                                hint: AppStrings.email_address,
                                maxLength: AppValidator.emailLength,
                                controller: email),
                            35.verticalSpace,
                            CustomInputField(
                                obscure: true,
                                maxLength: AppValidator.passwordLength,
                                validator: AppValidator.passValidator,
                                prefix: AppStrings.password.toUpperCase(),
                                hint: AppStrings.password,
                                controller: pass),
                            35.verticalSpace,
                            CustomInputField(
                              prefix: AppStrings.confirm_password
                                  .replaceAll(" ", "\n")
                                  .toUpperCase(),
                              hint: AppStrings.password,
                              maxLength: AppValidator.passwordLength,
                              controller: conf_pass,
                              obscure: true,
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  if (!(value.contains(pass.text))) {
                                    return "Password doesn't match";
                                  }
                                } else {
                                  return "Enter confirm password";
                                }
                              },
                            ),
                            35.verticalSpace,
                            CustomInputField(
                                maxLength: AppValidator.descriptiveLength,
                                prefix: AppStrings.address.toUpperCase(),
                                hint: AppStrings.address,
                                controller: address),
                            35.verticalSpace,
                            CustomInputField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return "fields can't be empty";
                                  } else if (value.length < 11) {
                                    return "Invalid Phone Number";
                                  }
                                },
                                prefix: AppStrings.phone.toUpperCase(),
                                hint: AppStrings.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                keyboardType: TextInputType.phone,
                                maxLength: AppValidator.phoneLength,
                                controller: phone),
                            35.verticalSpace,
                            SizedBox(
                                width: .5.sw,
                                child: CustomButton(
                                    onPress: () async {
                                      if (_key.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        final results =
                                            await FirebaseServices.signup(
                                                email.text, pass.text);
                                        setState(() {
                                          loading = false;
                                        });

                                        if (results != null) {
                                          AppNavigation.popallStack(
                                              const HomeScreen());
                                        }
                                      }
                                    },
                                    bgColor: Constants.backgroundColor,
                                    text: AppStrings.signup.toUpperCase(),
                                    fontColor: Colors.white,
                                    fontSize: 17.sp)),
                            60.verticalSpace,
                          ]),
                        ),
                      )
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
}
