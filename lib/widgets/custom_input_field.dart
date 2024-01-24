import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      this.maxLength,
      this.inputFormatters,
      this.enable = true,
      this.obscure = false});

  final String? prefix;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscure;
  final TextInputType? keyboardType;
  final bool enable;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool show = widget.obscure;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure ? show : false,
      obscuringCharacter: '*',
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          contentPadding:
              //
              // EdgeInsets.zero
              const EdgeInsets.all(5)
          //
          ,
          isDense: true,
          errorMaxLines: 3,
          errorStyle: TextStyle(fontSize: 11.sp),
          suffixIconConstraints:
              BoxConstraints(maxHeight: 18.h, maxWidth: 20.w),
          suffixIcon: widget.obscure
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      show = !show;
                    });
                  },
                  child: Icon(show
                      ? Icons.remove_red_eye
                      : Icons.visibility_off_rounded))
              : null,
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
          counterText: "",
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
