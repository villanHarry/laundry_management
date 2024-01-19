import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/product_card.dart';

class ProductPopup extends StatefulWidget {
  const ProductPopup({super.key});

  @override
  State<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  String dropDOwnValue = AppStrings.queue;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
          width: .8.sw,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  30.horizontalSpace,
                  const Spacer(),
                  ProductCard.heading("Product Name"),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Constants.bottomIcons(Icons.close, size: 30.r))
                ],
              ),
              3.verticalSpace,
              const Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          details(heading: "Title", detail: "value"),
                          details(
                              heading: AppStrings.amount, detail: "${0} PKR"),
                          details(heading: AppStrings.address, detail: "value"),
                        ],
                      ),
                    ),
                    const Divider(height: 0),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: ProductCard.heading("Status:")),
                          25.horizontalSpace,
                          Expanded(
                            child: DropdownButtonFormField<String>(
                                padding: EdgeInsets.zero,
                                enableFeedback: false,
                                alignment: Alignment.centerLeft,
                                decoration: InputDecoration(
                                    enabled: false,
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 5.h),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0.1, color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                value: dropDOwnValue,
                                style: AppTextStyle.regularTextStyle(
                                    fgColor: Colors.black, fontSize: 17.sp),
                                borderRadius: BorderRadius.circular(10),
                                items: ProductStatus.values
                                    .map((e) => DropdownMenuItem<String>(
                                        value: statusView[e],
                                        child: ProductCard.value(
                                            statusView[e] ?? "",
                                            align: TextAlign.end)))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      dropDOwnValue = value;
                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget details(
      {required String heading,
      required String detail,
      bool isPadding = true}) {
    return Padding(
      padding: isPadding ? EdgeInsets.only(bottom: 20.h) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [ProductCard.heading("$heading:"), ProductCard.value(detail)],
      ),
    );
  }
}
