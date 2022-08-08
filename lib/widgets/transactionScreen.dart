import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:max/widgets/getPurchaseTransaction.dart';
import 'package:max/widgets/getSalesTransaction.dart';
import 'package:max/widgets/getSpendingTransaction.dart';
import 'package:max/widgets/getTotalsTransaction.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';

class TransactionScreen extends StatefulWidget {
  @override
  TransactionScreenState createState() => TransactionScreenState();
}

class TransactionScreenState extends State<TransactionScreen> {
  TextEditingController? dateCtrl;
  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  @override
  void initState() {
    super.initState();
    dateCtrl = TextEditingController(text: DateTime.now().toString());
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
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .15,
                    height: 75,
                    child: DateTimePicker(
                      dateMask: 'd MMM, yyyy',
                      controller: dateCtrl,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date'.tr,
                      onChanged: (val) => setState(() => dateVal = val),
                      validator: (val) {
                        setState(() => _valueToValidate = val ?? '');
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            children: [
                              TableRow(children: [
                                tableColumn(
                                  label: 'Input'.tr,
                                ),
                              ]),
                            ]),
                        Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            children: [
                              TableRow(children: [
                                tableColumn(
                                  label: 'Output'.tr,
                                ),
                              ]),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            children: [
                              TableRow(children: [
                                tableColumn(
                                  label: 'Details'.tr,
                                ),
                                tableColumn(
                                  label: 'Cash'.tr,
                                ),
                              ]),
                            ]),
                        Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            children: [
                              TableRow(children: [
                                tableColumn(
                                  label: 'Details'.tr,
                                ),
                                tableColumn(
                                  label: 'Cash'.tr,
                                ),
                              ]),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Table(
                            defaultColumnWidth: FixedColumnWidth(180.0),
                            children: [
                              TableRow(children: [
                                GetSalesTransaction(
                                  date: dateCtrl!.text,
                                ),
                              ]),
                            ]),
                        Table(
                            defaultColumnWidth: FixedColumnWidth(180.0),
                            children: [
                              TableRow(children: [
                                Column(
                                  children: [
                                    GetPurchaseTransaction(
                                      date: dateCtrl!.text,
                                    ),
                                    GetSpendingTransaction(
                                      date: dateCtrl!.text,
                                    ),
                                  ],
                                )
                              ]),
                            ]),
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            GetTotalsTransaction(
              date: dateCtrl!.text,
            ),
          ],
        ));
  }
}
