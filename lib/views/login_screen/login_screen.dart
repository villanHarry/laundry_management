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
import 'package:laundry_management/views/sign_up_screen/signup_screen.dart';
import 'package:laundry_management/widgets/custom_button.dart';
import 'package:laundry_management/widgets/custom_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController pass = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.darkMode,
        child: Scaffold(
          backgroundColor: Constants.backgroundColor,
          body: Stack(
            children: [
              SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      60.verticalSpace,
                      Row(children: [
                        const Spacer(),
                        Text(
                          AppStrings.loginHeading.toUpperCase(),
                          style: AppTextStyle.boldTextStyle(fontSize: 20.sp),
                        ),
                        const Spacer(),
                      ]),
                      8.verticalSpace,
                      Row(children: [
                        const Spacer(),
                        Text(
                          AppStrings.title.toUpperCase(),
                          style: AppTextStyle.boldTextStyle(fontSize: 20.sp),
                        ),
                        const Spacer(),
                      ]),
                      50.verticalSpace,
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
                            Text("${AppStrings.signin.toUpperCase()}!",
                                style: AppTextStyle.boldTextStyle(
                                    fgColor: Colors.black, fontSize: 22.sp)),
                            50.verticalSpace,
                            CustomInputField(
                                prefix: AppStrings.email.toUpperCase(),
                                hint: AppStrings.email_address,
                                controller: email,
                                validator: AppValidator.emailValidator,
                                maxLength: AppValidator.emailLength),
                            35.verticalSpace,
                            CustomInputField(
                                prefix: AppStrings.password.toUpperCase(),
                                hint: AppStrings.password,
                                obscure: true,
                                validator: AppValidator.passValidator,
                                controller: pass,
                                maxLength: AppValidator.passwordLength),
                            70.verticalSpace,
                            SizedBox(
                                width: .5.sw,
                                child: CustomButton(
                                    onPress: () async {
                                      if (_key.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        final results =
                                            await FirebaseServices.login(
                                                email.text, pass.text);

                                        setState(() {
                                          loading = false;
                                        });
                                        if (results != null) {
                                          AppNavigation.popallStack(HomeScreen(
                                              admin: results.user!.email ==
                                                  "admin@gmail.com"));
                                        }
                                      }
                                    },
                                    bgColor: Constants.backgroundColor,
                                    text: AppStrings.signin.toUpperCase(),
                                    fontColor: Colors.white,
                                    fontSize: 17.sp)),
                            15.verticalSpace,
                            GestureDetector(
                              onTap: () {
                                AppNavigation.push(const SignupScreen());
                              },
                              child: Text(
                                  "If you don't have an account, sign up.",
                                  style: AppTextStyle.boldTextStyle(
                                      fgColor: Colors.grey.shade700,
                                      fontSize: 13.sp)),
                            ),
                            50.verticalSpace,
                          ]),
                        ),
                      )
                    ],
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
          ),
        ));
  }
}
