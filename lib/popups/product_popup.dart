import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry_management/models/order_model.dart';
import 'package:laundry_management/providers/orders_provider.dart';
import 'package:laundry_management/services/order_apis.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/custom_button.dart';
import 'package:laundry_management/widgets/printable_data.dart';
import 'package:laundry_management/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductPopup extends StatefulWidget {
  const ProductPopup({super.key, this.id});

  final String? id;

  @override
  State<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  late final OrderModel order = context
      .read<OrdersProvider>()
      .orders
      .firstWhere((element) => element.id == widget.id);
  late String dropDOwnValue = order.status ?? AppStrings.queue;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Stack(
        children: [
          Dialog(
            insetPadding: EdgeInsets.zero,
            child: Container(
                width: .8.sw,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        30.horizontalSpace,
                        const Spacer(),
                        ProductCard.heading("Reciept"),
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                Constants.bottomIcons(Icons.close, size: 30.r))
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
                                details(
                                    heading: "Title",
                                    detail: order.name ?? "value"),
                                details(
                                    heading: AppStrings.amount,
                                    detail:
                                        "${order.amount!.toStringAsFixed(0)} PKR"),
                                details(
                                    heading: AppStrings.address,
                                    detail: order.address ?? "value"),
                                details(
                                    heading: AppStrings.phone,
                                    detail: order.phone ?? "phone"),
                                details(
                                    heading: AppStrings.retur,
                                    detail: order.retur ??
                                        DateFormat("dd-MM-yyyy")
                                            .format(DateTime.now()))
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
                                                  width: 0.1,
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      value: dropDOwnValue,
                                      style: AppTextStyle.regularTextStyle(
                                          fgColor: Colors.black,
                                          fontSize: 17.sp),
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
                          ),
                          Visibility(
                            visible: dropDOwnValue != order.status,
                            child: Column(
                              children: [
                                20.verticalSpace,
                                CustomButton(
                                    onPress: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      loading = await context
                                          .read<OrdersProvider>()
                                          .editStatus(
                                              id: widget.id,
                                              status: dropDOwnValue);
                                      setState(() {});
                                      AppNavigation.pop();
                                    },
                                    bgColor: Constants.backgroundColor,
                                    text: "Edit".toUpperCase(),
                                    fontColor: Colors.white,
                                    fontSize: 17.sp),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
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

class ProductPopup2 extends StatefulWidget {
  const ProductPopup2({super.key, this.id});

  final String? id;

  @override
  State<ProductPopup2> createState() => _ProductPopup2State();
}

class _ProductPopup2State extends State<ProductPopup2> {
  late final OrderModel order = context
      .read<OrdersProvider>()
      .orders
      .firstWhere((element) => element.id == widget.id);

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
                  ProductCard.heading("Reciept"),
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
                          details(
                              heading: "Title", detail: order.name ?? "value"),
                          details(
                              heading: AppStrings.amount,
                              detail:
                                  "${order.amount!.toStringAsFixed(0)} PKR"),
                          details(
                              heading: AppStrings.address,
                              detail: order.address ?? "value"),
                          details(
                              heading: AppStrings.phone,
                              detail: order.phone ?? "phone"),
                          details(
                              heading: AppStrings.retur,
                              detail: order.retur ??
                                  DateFormat("dd-MM-yyyy")
                                      .format(DateTime.now()))
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
                          Text(order.status ?? "status",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 16.sp,
                              ))
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    CustomButton(
                        onPress: () async {
                          await buildPrintableData(
                              status: statusView[ProductStatus.queue]!,
                              amount: order.amount ?? 0,
                              address: order.address ?? "",
                              name: order.name ?? "",
                              phone: order.phone ?? "",
                              retur: order.retur ?? "");

                          AppNavigation.pop();
                        },
                        bgColor: Constants.backgroundColor,
                        text: AppStrings.print.toUpperCase(),
                        fontColor: Colors.white,
                        fontSize: 17.sp),
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
