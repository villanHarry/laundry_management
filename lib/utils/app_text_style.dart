import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle boldTextStyle(
          {double? fontSize,
          Color fgColor = Colors.white,
          double? height,
          TextOverflow? overflow}) =>
      TextStyle(
          overflow: overflow,
          color: fgColor,
          fontSize: fontSize ?? 24.sp,
          height: height ?? 1,
          fontWeight: FontWeight.bold);
  static TextStyle regularTextStyle(
          {double? fontSize,
          Color fgColor = Colors.white,
          double? height,
          TextOverflow? overflow}) =>
      TextStyle(
          overflow: overflow,
          color: fgColor,
          fontSize: fontSize ?? 24.sp,
          height: height ?? 1);
}
