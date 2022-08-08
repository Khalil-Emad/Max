import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/SalesRows.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/invoicePrint.dart';
import 'package:max/widgets/tableColumn.dart';
import 'package:oktoast/oktoast.dart';
import '../../../constants/constants.dart';
import '../constants/global.dart';
import '../objects/salesInvoice.dart';

class SalesForm extends StatefulWidget {
  @override
  SalesFormState createState() => SalesFormState();
}

class SalesFormState extends State<SalesForm> {
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController discountCtrl = TextEditingController();
  TextEditingController cashCtrl = TextEditingController();
  TextEditingController customerNameCtrl = TextEditingController();
  TextEditingController customerMobileCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController barcodeCtrl = TextEditingController();
  String dateVal = '';
  int cash = 0;
  // ignore: unused_field
  String _valueToValidate = '';
  int row = 0;
  String barcode = "0000";
  List<SalesInvoice> items = [];
  FocusNode? myFocusNode;

  getSalesInvoiceNum() async {
    numberCtrl.text = await SalesInvoice.getSalesInvoiceNum();
  }

  getItem() async {
    items = await SalesInvoice.getItem(barcode, numberCtrl.text);
  }

  @override
  void initState() {
    super.initState();
    getSalesInvoiceNum();
    getItem();
    dateCtrl = TextEditingController(text: DateTime.now().toString());
    discountCtrl = TextEditingController(text: "");
    myFocusNode = FocusNode();
    Global.totalSalesPrice = "0";
    cash = int.parse(Global.totalSalesPrice) -
        int.parse(discountCtrl.text == "" ? "0" : discountCtrl.text);
    cashCtrl.text = cash.toString();
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
                        controller: numberCtrl,
                        readOnly: true,
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
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.event),
                      dateLabelText: 'Date'.tr,
                      onChanged: (val) => setState(() {
                        dateVal = val;
                        dateCtrl.text = dateVal;
                      }),
                      validator: (val) {
                        setState(() => _valueToValidate = val ?? '');
                        return null;
                      },
                    ),
                  ),
                  Container(
                    width: size.width * .114,
                    height: size.height * .05,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (row < 9) {
                          setState(() {
                            row++;
                          });
                        }
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add Item".tr),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: Responsive.isMobile(context)
                                ? defaultPadding / 2
                                : defaultPadding),
                      ),
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
                            tableColumn(
                              label: '',
                            ),
                          ]),
                          TableRow(children: [
                            Column(children: [
                              SizedBox(
                                width: size.width * .08,
                                child: TextField(
                                    controller: barcodeCtrl,
                                    autofocus: true,
                                    focusNode: myFocusNode,
                                    onSubmitted: (val) async {
                                      setState(() {
                                        barcode = val.trim();
                                      });

                                      items = await SalesInvoice.getItem(
                                          barcode, numberCtrl.text);
                                      setState(() {
                                        if (items.length != 0) {
                                          items = items;
                                          if (row < 4) {
                                            row++;
                                          }
                                          cash = int.parse(
                                                  Global.totalSalesPrice) -
                                              int.parse(discountCtrl.text == ""
                                                  ? "0"
                                                  : discountCtrl.text);
                                          cashCtrl.text = cash.toString();
                                        } else {
                                          showToast(
                                              "This Item is Sold Before".tr);
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Barcode'.tr,
                                    )),
                              ),
                            ]),
                            tableColumn(
                                label: items.isEmpty
                                    ? ""
                                    : CurrentUser.language == "en"
                                        ? items[0].categoryName!
                                        : items[0].categoryNameAr!),
                            tableColumn(
                                label:
                                    items.isEmpty ? "" : items[0].modelCode!),
                            tableColumn(
                                label: items.isEmpty ? "" : items[0].size!),
                            tableColumn(
                                label: items.isEmpty ? "" : items[0].color!.tr),
                            tableColumn(
                                label:
                                    items.isEmpty ? "" : items[0].salePrice!),
                            OutlinedButton(
                              onPressed: () async {
                                bool sucess = await SalesInvoice.deleteItem(
                                    items[0].barcode);
                                if (sucess == true) {
                                  showToast(
                                    "Done",
                                  );
                                  setState(() {
                                    items.clear();
                                    barcodeCtrl.text = "";
                                  });
                                } else {
                                  showToast(
                                    "Error",
                                  );
                                }
                              },
                              child: Icon(Icons.delete),
                            ),
                          ]),
                        ]),
                    Offstage(
                        offstage: row < 10 && row > 0 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 1 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 2 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 3 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 4 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 5 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 6 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 7 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
                    Offstage(
                        offstage: row < 10 && row > 8 ? false : true,
                        child: SalesRows(invoiceId: numberCtrl.text)),
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
                    Global.totalSalesPrice,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 300,
                  ),
                  SizedBox(
                    width: size.width * .1,
                    child: TextField(
                        onSubmitted: (val) {
                          setState(() {
                            customerNameCtrl.text = val;
                          });
                        },
                        controller: customerNameCtrl,
                        decoration: InputDecoration(
                          labelText: 'Name'.tr,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
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
                    width: 80,
                  ),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: TextField(
                        onTap: () {
                          setState(() {
                            Global.totalSalesPrice = Global.totalSalesPrice;
                            setState(() {
                              cash = int.parse(Global.totalSalesPrice) -
                                  int.parse(discountCtrl.text == ""
                                      ? "0"
                                      : discountCtrl.text);
                              cashCtrl.text = cash.toString();
                            });
                            // discountCtrl.text = "0";
                          });
                        },
                        onSubmitted: (val) {
                          setState(() {
                            discountCtrl.text = val;
                            cash = int.parse(Global.totalSalesPrice) -
                                int.parse(discountCtrl.text);
                            cashCtrl.text = cash.toString();
                          });
                        },
                        controller: discountCtrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        )),
                  ),
                  SizedBox(
                    width: 240,
                  ),
                  SizedBox(
                    width: size.width * .1,
                    child: TextField(
                        controller: customerMobileCtrl,
                        onSubmitted: (val) {
                          setState(() {
                            customerMobileCtrl.text = val;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Mobile'.tr,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
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
                    "Cash:".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  Text(
                    "${cashCtrl.text} LE",
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
                        cash = int.parse(Global.totalSalesPrice) -
                            int.parse(discountCtrl.text == ""
                                ? "0"
                                : discountCtrl.text);
                        cashCtrl.text = cash.toString();
                        bool sucess = await SalesInvoice.submit(
                            dateCtrl.text,
                            numberCtrl.text,
                            discountCtrl.text,
                            customerNameCtrl.text,
                            customerMobileCtrl.text);
                        if (sucess) {
                          Get.to(() => invoicePrint(
                                invoiceId: numberCtrl.text,
                              ));
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
                ],
              ),
            ),
          ],
        ));
  }
}
