import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry_management/utils/app_strings.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

buildPrintableData(
    {required String status,
    required double amount,
    required String address,
    required String name,
    required String phone,
    required String retur}) async {
  final doc = pw.Document();
  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(25.00),
          child: pw.Column(children: [
            pw.Text("Laundry Management",
                style: pw.TextStyle(
                    fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10.00),
            pw.Divider(),
            pw.Column(
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.SizedBox(width: 5.5),
                    pw.Text(
                      "Invoice",
                      style: pw.TextStyle(
                          fontSize: 23.00, fontWeight: pw.FontWeight.bold),
                    )
                  ],
                ),
                pw.SizedBox(height: 10.00),
                pw.Container(
                  color: PdfColor.fromHex("#2646B7"),
                  width: double.infinity,
                  height: 36.00,
                  child: pw.Center(
                    child: pw.Text(
                      "Order Confirmed!",
                      style: pw.TextStyle(
                          color: const PdfColor(1, 1, 1),
                          fontSize: 20.00,
                          fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ),
                pw.Row(children: [
                  pw.Spacer(),
                  pw.Text("Product Name",
                      textAlign: pw.TextAlign.start,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor(0, 0, 0),
                        fontSize: 16.sp,
                      )),
                  pw.Spacer(),
                ]),
                pw.SizedBox(height: 3.h),
                pw.Divider(),
                pw.Container(
                  padding: pw.EdgeInsets.symmetric(vertical: 10.h),
                  child: pw.Column(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.symmetric(horizontal: 10.w),
                        child: pw.Column(
                          children: [
                            details(heading: "Title", detail: name),
                            details(
                                heading: AppStrings.address, detail: address),
                            details(heading: AppStrings.phone, detail: phone),
                            details(
                                heading: AppStrings.amount,
                                detail: "$amount PKR"),
                            details(heading: AppStrings.retur, detail: retur)
                          ],
                        ),
                      ),
                      pw.Divider(height: 0),
                      pw.Padding(
                        padding: pw.EdgeInsets.only(top: 20.h),
                        child: pw.Row(
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.only(left: 10.w),
                              child: pw.Text("Status: ",
                                  textAlign: pw.TextAlign.start,
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: const PdfColor(0, 0, 0),
                                    fontSize: 16.sp,
                                  )),
                            ),
                            pw.SizedBox(height: 25.w),
                            pw.Text(status,
                                textAlign: pw.TextAlign.start,
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal,
                                  color: const PdfColor(0, 0, 0),
                                  fontSize: 16.sp,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                pw.SizedBox(height: 15.00),
                pw.Text(
                  "Thanks for choosing our service!",
                  style: const pw.TextStyle(
                      color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
                ),
                pw.SizedBox(height: 5.00),
                pw.Text(
                  "Contact the branch for any clarifications.",
                  style: const pw.TextStyle(
                      color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
                ),
                pw.SizedBox(height: 15.00),
              ],
            )
          ]),
        );
      }));
  Constants.showToast("Printing...");
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}

pw.Widget details(
    {required String heading, required String detail, bool isPadding = true}) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(bottom: 20.h),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text("$heading:",
            textAlign: pw.TextAlign.start,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: const PdfColor(0, 0, 0),
              fontSize: 16.sp,
            )),
        pw.Text(detail,
            textAlign: pw.TextAlign.start,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.normal,
              color: const PdfColor(0, 0, 0),
              fontSize: 16.sp,
            ))
      ],
    ),
  );
}
