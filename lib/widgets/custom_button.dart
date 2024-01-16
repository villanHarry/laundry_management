import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {this.text,
      this.fontSize,
      this.onPress,
      this.bgColor,
      this.fontColor,
      super.key});

  final double? fontSize;
  final String? text;
  final Color? bgColor;
  final Color? fontColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
            color: bgColor ?? Colors.white,
            borderRadius: BorderRadius.circular(50.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? "",
              style: AppTextStyle.boldTextStyle(
                  fontSize: fontSize ?? 19.sp,
                  fgColor: fontColor ?? Constants.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
