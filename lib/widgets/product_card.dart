import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/popups/product_popup.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(
      {super.key,
      this.id,
      this.title,
      this.amount,
      this.address,
      this.status,
      this.admin = false});

  final String? id, title, amount, address, status;
  final bool admin;

  @override
  State<ProductCard> createState() => _ProductCardState();

  static Widget heading(String heading, {double? fontSize}) => Text(heading,
      textAlign: TextAlign.start,
      style: AppTextStyle.boldTextStyle(
          fgColor: Colors.black,
          fontSize: fontSize ?? 16.sp,
          overflow: TextOverflow.ellipsis));
  static Widget value(String value, {align = TextAlign.start}) => Text(value,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyle.regularTextStyle(
          fgColor: Colors.black, fontSize: 16.sp));
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return widget.admin
                  ? ProductPopup(id: widget.id)
                  : ProductPopup2(id: widget.id);
            });
      },
      child: entry(
          title: widget.title,
          address: widget.address,
          amount: widget.amount,
          status: widget.status),
    );
  }

  Widget entry(
          {String? title, String? amount, String? address, String? status}) =>
      Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 15.r),
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(children: [
                ProductCard.heading(title ?? "Title"),
                const Spacer(),
                ProductCard.value(amount ?? "10 PKR")
              ]),
              5.verticalSpace,
              Row(children: [
                SizedBox(
                    width: 100.w,
                    child: ProductCard.value(address ?? "Address")),
                const Spacer(),
                ProductCard.value(status ?? "Queue", align: TextAlign.end)
              ]),
            ],
          ),
        ),
      );
}

enum ProductStatus { queue, washing, being_washed, being_prepared, done }

Map<ProductStatus, String> statusView = {
  ProductStatus.queue: AppStrings.queue,
  ProductStatus.washing: AppStrings.washing,
  ProductStatus.being_washed: AppStrings.being_washed,
  ProductStatus.being_prepared: AppStrings.being_prepared,
  ProductStatus.done: AppStrings.done,
};
