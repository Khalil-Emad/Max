import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max/widgets/getPurchaseReport.dart';
import 'package:max/widgets/tableColumn.dart';

import '../../../constants/constants.dart';
import 'getTotalPurchases.dart';

class PurchasesReport extends StatefulWidget {
  @override
  PurchasesReportState createState() => PurchasesReportState();
}

class PurchasesReportState extends State<PurchasesReport> {
  TextEditingController? startDateCtrl, endDateCtrl;
  String startDateVal = '';
  String endDateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  final format = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    super.initState();
    startDateCtrl = TextEditingController(text: DateTime.now().toString());
    endDateCtrl = TextEditingController(text: DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Purchases Report".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                width: size.width * .15,
                height: 75,
                child: DateTimePicker(
                  dateMask: 'd MMM, yyyy',
                  controller: startDateCtrl,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Start Date'.tr,
                  onChanged: (val) => setState(() => startDateVal = val),
                  validator: (val) {
                    setState(() => _valueToValidate = val ?? '');
                    return null;
                  },
                ),
              ),
              SizedBox(
                width: size.width * .15,
                height: 75,
                child: DateTimePicker(
                  dateMask: 'd MMM, yyyy',
                  controller: endDateCtrl,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'End Date'.tr,
                  onChanged: (val) => setState(() => endDateVal = val),
                  validator: (val) {
                    setState(() => _valueToValidate = val ?? '');
                    return null;
                  },
                ),
              ),
              // SizedBox(
              //   width: 140,
              //   height: 40,
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       setState(() {
              //         startDateVal.isNotEmpty
              //             ? startDateCtrl!.text = startDateVal
              //             : startDateCtrl!.text = startDateCtrl!.text;
              //         endDateVal.isNotEmpty
              //             ? endDateCtrl!.text = endDateVal
              //             : endDateCtrl!.text = endDateCtrl!.text;
              //       });
              //     },
              //     icon: Icon(Icons.confirmation_num),
              //     label: Text("Submit".tr),
              //     style: TextButton.styleFrom(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: defaultPadding * 1.5,
              //           vertical: Responsive.isMobile(context)
              //               ? defaultPadding / 2
              //               : defaultPadding),
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          tableColumn(
                            label: 'Invoice Number',
                          ),
                          tableColumn(
                            label: 'Date',
                          ),
                          tableColumn(
                            label: 'Count',
                          ),
                          tableColumn(
                            label: 'Total',
                          ),
                          tableColumn(
                            label: 'Cash',
                          ),
                        ]),
                        TableRow(children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ]),
                      ]),
                  GetPurchaseReport(
                    startDate: startDateCtrl!.text,
                    endDate: endDateCtrl!.text,
                  ),
                ],
              )),
          Divider(color: Colors.white),
          GetTotalsPurchases(
            startDate: startDateCtrl!.text,
            endDate: endDateCtrl!.text,
          ),
        ],
      ),
    );
  }
}
