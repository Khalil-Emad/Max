import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/salesInvoice.dart';
import 'package:max/screens/home/main_screen.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';
import 'getSalesReturn.dart';
import 'invoicePrint.dart';

class SalesReturnForm extends StatefulWidget {
  @override
  SalesReturnFormState createState() => SalesReturnFormState();
}

class SalesReturnFormState extends State<SalesReturnForm> {
  TextEditingController formNumberCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  String type = "1";
  List<SalesInvoice> dataInvoice = [];

  @override
  void initState() {
    super.initState();
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
                    width: size.width * .1,
                    child: TextField(
                        controller: formNumberCtrl,
                        onSubmitted: (val) async {
                          setState(() {
                            formNumberCtrl.text = val;
                          });
                          dataInvoice = await SalesInvoice.getInvoicePrintTotal(
                              formNumberCtrl.text);
                          setState(() {
                            type = "2";
                          });
                          dataInvoice.isNotEmpty
                              ? dateCtrl.text = dataInvoice[0].date!
                              : dateCtrl.text = "";
                        },
                        decoration: InputDecoration(
                          labelText: 'Number'.tr,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
                  ),
                  SizedBox(
                    width: size.width * .15,
                    height: 75,
                    child: DateTimePicker(
                      enabled: false,
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
                    Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
                            tableColumn(
                              label: 'Barcode',
                            ),
                            tableColumn(
                              label: 'Category',
                            ),
                            tableColumn(
                              label: 'Model',
                            ),
                            tableColumn(
                              label: 'Size',
                            ),
                            tableColumn(
                              label: 'Color',
                            ),
                            tableColumn(
                              label: 'Price',
                            ),
                          ]),
                        ]),
                    formNumberCtrl.text.isNotEmpty
                        ? GetSalesReturn(invoiceId: formNumberCtrl.text)
                        : Container(),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 40),
              child: Row(
                children: [
                  Text(
                    "Total :".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    dataInvoice.isNotEmpty ? dataInvoice[0].total! : "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 40),
              child: Row(
                children: [
                  Text(
                    "Discount :".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    dataInvoice.isNotEmpty ? dataInvoice[0].discount! : "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 60),
              child: Row(
                children: [
                  Text(
                    "Cash :".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    dataInvoice.isNotEmpty ? dataInvoice[0].cash! : "",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 300,
                  ),
                  Container(
                    width: 140,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        bool success = await SalesInvoice.getSalesReturn(
                            formNumberCtrl.text);
                        if (success) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        }
                      },
                      icon: Icon(Icons.confirmation_num),
                      label: Text("Submit".tr),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: Responsive.isMobile(context)
                                ? defaultPadding / 2
                                : defaultPadding),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Container(
                    width: size.width * .1,
                    height: size.height * .05,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        Get.to(() => invoicePrint(
                              invoiceId: formNumberCtrl.text,
                            ));
                      },
                      icon: Icon(Icons.print),
                      label: Text("Print".tr),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.4,
                            vertical: Responsive.isMobile(context)
                                ? defaultPadding / 2
                                : defaultPadding),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
