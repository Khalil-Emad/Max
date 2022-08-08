import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';
import '../objects/PurchaseInvoice.dart';
import 'barcodePrint.dart';
import 'getPurchaseReturn.dart';

class PurchaseReturnForm extends StatefulWidget {
  @override
  PurchaseReturnFormState createState() => PurchaseReturnFormState();
}

class PurchaseReturnFormState extends State<PurchaseReturnForm> {
  TextEditingController formNumberCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();

  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  String type = "1";
  List<PurchaseInvoice> data = [];

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
                          data = await PurchaseInvoice.getPurchaseReturn(
                              formNumberCtrl.text, "0", type);
                          setState(() {
                            type = "2";
                          });

                          dateCtrl.text = data[0].date!;
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
                      dateMask: 'd MMM, yyyy',
                      controller: dateCtrl,
                      enabled: false,
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
                              label: 'Purchase Price',
                            ),
                            tableColumn(
                              label: 'Sale Price',
                            ),
                          ]),
                        ]),
                    formNumberCtrl.text.isNotEmpty && type == "2"
                        ? GetPurchaseReturn(
                            invoiceId: formNumberCtrl.text,
                          )
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
                    data.isNotEmpty ? data[0].total! : "",
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
                    "Cash :".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    data.isNotEmpty ? data[0].cash! : "",
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
                        await PurchaseInvoice.getPurchaseReturn(
                            formNumberCtrl.text, "1", type);
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => barcodePrint(
                                    invoicePurchaseId:
                                        int.parse(formNumberCtrl.text))));
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
