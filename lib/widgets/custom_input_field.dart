import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_text_style.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField(
      {super.key,
      this.prefix,
      this.hint,
      this.controller,
      this.validator,
      this.keyboardType,
      this.enable = true});

  final String? prefix;
  final String? hint;
  final TextEditingController? controller;
  final String Function(String?)? validator;

  final TextInputType? keyboardType;
  final bool enable;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          contentPadding:
              //
              // EdgeInsets.zero
              const EdgeInsets.all(5)
          //
          ,
          isDense: true,
          hintStyle: AppTextStyle.regularTextStyle(
              fgColor: Colors.grey.shade800, fontSize: 16.sp),
          prefixIconConstraints: BoxConstraints(minHeight: 15.h),
          prefixIcon: Padding(
            padding: EdgeInsets.only(
                right: 15.w,
                left:
                    //
                    0
                //15.w
                //
                ),
            child: Text(widget.prefix ?? "",
                style: AppTextStyle.boldTextStyle(
                    fgColor: Colors.black, fontSize: 16.sp)),
          ),
          hintText: widget.hint ?? ""),
      validator: widget.validator ??
          (value) {
            if (value!.isEmpty) {
              return "fields can't be empty";
            }
          },
    );
  }
}
