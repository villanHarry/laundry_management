import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:laundry_management/providers/orders_provider.dart';
import 'package:laundry_management/services/order_apis.dart';
import 'package:laundry_management/utils/app_navigation.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/app_text_style.dart';
import 'package:laundry_management/utils/app_validator.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/widgets/custom_button.dart';
import 'package:laundry_management/widgets/custom_input_field.dart';
import 'package:laundry_management/widgets/printable_data.dart';
import 'package:laundry_management/widgets/product_card.dart';
import 'package:provider/provider.dart';

class PrintScreen extends StatefulWidget {
  const PrintScreen({super.key});

  @override
  State<PrintScreen> createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController nOfClothes = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool loading = false;

  @override
  void initState() {
    nOfClothes.addListener(() {
      if (nOfClothes.text.isNotEmpty) {
        amount.text = "${int.parse(nOfClothes.text) * 25}";
      } else {
        amount.text = "0";
      }
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    nOfClothes.removeListener(() {});
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: Constants.lightMode,
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
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 30.h),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(40))),
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
                      Form(
                        key: _key,
                        child: Container(
                          width: .9.sw,
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 40.h),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                          child: Column(children: [
                            CustomInputField(
                              controller: name,
                              maxLength: AppValidator.emailLength,
                              prefix: AppStrings.name.toUpperCase(),
                              hint: AppStrings.name,
                            ),
                            35.verticalSpace,
                            CustomInputField(
                              maxLength: AppValidator.descriptiveLength,
                              controller: address,
                              prefix: AppStrings.address.toUpperCase(),
                              hint: AppStrings.address,
                            ),
                            35.verticalSpace,
                            CustomInputField(
                              maxLength: AppValidator.phoneLength,
                              controller: phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              prefix: AppStrings.phone.toUpperCase(),
                              hint: AppStrings.phone,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "fields can't be empty";
                                } else if (value.length < 11) {
                                  return "Invalid Phone Number";
                                }
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            35.verticalSpace,
                            CustomInputField(
                              controller: nOfClothes,
                              prefix: AppStrings.no_of_clothes.toUpperCase(),
                              hint: "0",
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "fields can't be empty";
                                } else if (int.parse(value) <= 0) {
                                  return "Invalid Number";
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                            ),
                            35.verticalSpace,
                            CustomInputField(
                              controller: amount,
                              enable: false,
                              prefix: AppStrings.amount.toUpperCase(),
                              hint: "0",
                              keyboardType: TextInputType.phone,
                            ),
                            35.verticalSpace,
                            // CustomInputField(
                            //   prefix: AppStrings.paid.toUpperCase(),
                            //   hint: "0",
                            //   keyboardType: TextInputType.phone,
                            // ),
                            // 35.verticalSpace,
                            // CustomInputField(
                            //   prefix: AppStrings.remaining.toUpperCase(),
                            //   hint: "0",
                            //   keyboardType: TextInputType.phone,
                            // ),
                            // 35.verticalSpace,
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
                                          DateFormat("dd-MM-yyyy")
                                              .format(value);
                                    });
                                  }
                                });
                              },
                              child: CustomInputField(
                                prefix: AppStrings.retur.toUpperCase(),
                                hint: "dd-MM-yyyy",
                                keyboardType: TextInputType.phone,
                                controller: dateController,
                                enable: false,
                              ),
                            ),
                            35.verticalSpace,
                            SizedBox(
                                width: .5.sw,
                                child: CustomButton(
                                    onPress: () async {
                                      if (_key.currentState!.validate()) {
                                        setState(() {
                                          loading = true;
                                        });
                                        await OrderAPIs.createOrder(
                                            status: statusView[
                                                ProductStatus.queue]!,
                                            amount: double.parse(amount.text),
                                            address: address.text,
                                            name: name.text,
                                            phone: phone.text,
                                            retur: dateController.text);
                                        await context
                                            .read<OrdersProvider>()
                                            .getOrder();
                                        await buildPrintableData(
                                            status: statusView[
                                                ProductStatus.queue]!,
                                            amount: double.parse(amount.text),
                                            address: address.text,
                                            name: name.text,
                                            phone: phone.text,
                                            retur: dateController.text);
                                        setState(() {
                                          loading = false;
                                        });
                                        AppNavigation.pop();
                                      }
                                    },
                                    bgColor: Constants.backgroundColor,
                                    text: AppStrings.print.toUpperCase(),
                                    fontColor: Colors.white,
                                    fontSize: 17.sp)),
                          ]),
                        ),
                      ),
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
