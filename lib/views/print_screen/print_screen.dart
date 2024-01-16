import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/custom_button.dart';
import 'package:laundry_management/widgets/custom_input_field.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController dateController = TextEditingController();

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
                      const Spacer(),
                      Text(
                        AppStrings.print.toUpperCase(),
                        style: AppTextStyle.boldTextStyle(
                            fontSize: 21.sp, fgColor: Colors.black),
                      ),
                      const Spacer(),
                      30.horizontalSpace
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
                    CustomInputField(
                      prefix: AppStrings.name.toUpperCase(),
                      hint: AppStrings.name,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.address.toUpperCase(),
                      hint: AppStrings.address,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.phone.toUpperCase(),
                      hint: AppStrings.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.no_of_clothes.toUpperCase(),
                      hint: "0",
                      keyboardType: TextInputType.phone,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.amount.toUpperCase(),
                      hint: "0",
                      keyboardType: TextInputType.phone,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.paid.toUpperCase(),
                      hint: "0",
                      keyboardType: TextInputType.phone,
                    ),
                    35.verticalSpace,
                    CustomInputField(
                      prefix: AppStrings.remaining.toUpperCase(),
                      hint: "0",
                      keyboardType: TextInputType.phone,
                    ),
                    35.verticalSpace,
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)))
                            .then((value) {
                          if (value != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat("dd-MM-yyyy").format(value);
                            });
                          }
                        });
                      },
                      child: CustomInputField(
                        prefix: AppStrings.retur.toUpperCase(),
                        hint: DateFormat("dd-MM-yyyy").format(DateTime.now()),
                        keyboardType: TextInputType.phone,
                        controller: dateController,
                        enable: false,
                      ),
                    ),
                    35.verticalSpace,
                    SizedBox(
                        width: .5.sw,
                        child: CustomButton(
                            onPress: () {
                              Constants.showToast("Printing..");
                              AppNavigation.pop();
                            },
                            bgColor: Constants.backgroundColor,
                            text: AppStrings.print.toUpperCase(),
                            fontColor: Colors.white,
                            fontSize: 17.sp)),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
