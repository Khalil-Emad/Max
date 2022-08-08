import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/category.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/constants/global.dart';
import 'package:max/widgets/purchasesRows.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/tableColumn.dart';
import 'package:max/widgets/barcodePrint.dart';
import 'package:oktoast/oktoast.dart';
import '../objects/PurchaseInvoice.dart';
import '../objects/model.dart';

class PurchasesForm extends StatefulWidget {
  @override
  State<PurchasesForm> createState() => _PurchasesFormState();
}

class _PurchasesFormState extends State<PurchasesForm> {
  TextEditingController numberCtrl = new TextEditingController();
  TextEditingController purchasePriceCtrl = new TextEditingController();
  TextEditingController barcodeCtrl = new TextEditingController();
  TextEditingController totalCtrl = new TextEditingController();
  TextEditingController formCashCtrl = new TextEditingController();
  TextEditingController dateCtrl = new TextEditingController();
  TextEditingController categoryCtrl = new TextEditingController();
  TextEditingController modelCtrl = new TextEditingController();
  TextEditingController sizeCtrl = new TextEditingController();
  TextEditingController colorCtrl = new TextEditingController();
  TextEditingController sellPriceCtrl = new TextEditingController();

  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  int row = 0;
  List barcodes = [];
  Category? categoryValue;
  Model? modelValue;
  List<Category> categories = [];
  List<Model> models = [];

  getCategory() async {
    categories = await Category.getCategory();
    setState(() {
      categoryValue = categories[0];
      categoryCtrl.text = categoryValue!.id!;
                                        categoryCtrl.text = categoryValue!.id!;

    });
  }

  getModel() async {
    models = await Model.getModel();
    setState(() {
      modelValue = models[0];
    });
  }

  getPurchaseInvoiceNum() async {
    numberCtrl.text = await PurchaseInvoice.getPurchaseInvoiceNum();
  }

  @override
  void initState() {
    super.initState();
    dateCtrl = TextEditingController(text: DateTime.now().toString());
    Global.totalPurchasePrice = "0";
    getCategory();
    getModel();
    getPurchaseInvoiceNum();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                        textAlign: TextAlign.center,
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
                    width: size.width * .13,
                    height: 70,
                    child: DateTimePicker(
                      dateMask: 'd MMM, yyyy',
                      controller: dateCtrl,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      icon: Icon(Icons.calendar_today),
                      dateLabelText: 'Date'.tr,
                      onChanged: (val) {
                        setState(() {
                          dateVal = val;
                          // PurchaseInvoice.date = dateVal;
                        });
                      },
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
                        if (row < 14) {
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
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Table(
                        columnWidths: {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(2),
                          3: FlexColumnWidth(3),
                          4: FlexColumnWidth(3),
                          5: FlexColumnWidth(3),
                          6: FlexColumnWidth(4),
                          7: FlexColumnWidth(4),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(children: [
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
                              label: 'Sell Price',
                            ),
                            tableColumn(
                              label: 'Barcode',
                            ),
                            tableColumn(
                              label: '',
                            ),
                          ]),
                          TableRow(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                child: DropdownButtonFormField<Category>(
                                    isExpanded: true,
                                    hint: FittedBox(child: Text('Category'.tr)),
                                    value: categoryValue,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 30,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    validator: (value) =>
                                        value == null ? 'Is Required' : null,
                                    onChanged: (Category? newValue) {
                                      setState(() {
                                        categoryValue = newValue!;
                                        categoryCtrl.text = categoryValue!.id!;
                                      });
                                    },
                                    items: categories.map((Category category) {
                                      return DropdownMenuItem<Category>(
                                          value: category,
                                          child: FittedBox(
                                              child: Text(
                                                  CurrentUser.language == "en"
                                                      ? category.categoryName!
                                                      : category
                                                          .categoryNameAr!)));
                                    }).toList()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                TextField(
                                  controller: modelCtrl,
                                  onSubmitted: (val) {
                                    setState(() {
                                      modelCtrl.text = val;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                TextField(
                                    controller: sizeCtrl,
                                    onSubmitted: (val) {
                                      setState(() {
                                        sizeCtrl.text = val;
                                      });
                                    },
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ])
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                TextField(
                                  controller: colorCtrl,
                                  onSubmitted: (val) {
                                    setState(() {
                                      colorCtrl.text = val;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.text,
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                new TextField(
                                  controller: purchasePriceCtrl,
                                  onSubmitted: (val) {
                                    setState(() {
                                      purchasePriceCtrl.text = val;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                new TextField(
                                  controller: sellPriceCtrl,
                                  onSubmitted: (val) {
                                    setState(() {
                                      sellPriceCtrl.text = val;
                                    });
                                  },
                                  textAlign: TextAlign.center,
                                  decoration: new InputDecoration(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onEditingComplete: () async {
                                    barcodeCtrl.text =
                                        await PurchaseInvoice.getBarcode(
                                            categoryCtrl.text,
                                            modelCtrl.text,
                                            sizeCtrl.text,
                                            colorCtrl.text,
                                            purchasePriceCtrl.text,
                                            sellPriceCtrl.text,
                                            numberCtrl.text);
                                    setState(() {
                                      Global.totalPurchasePrice =
                                          Global.totalPurchasePrice;
                                    });
                                  },
                                )
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                readOnly: true,
                                controller: barcodeCtrl,
                                textAlign: TextAlign.center,
                                decoration: new InputDecoration(),
                                style: TextStyle(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 15, left: 15, top: 8, bottom: 8),
                              child: OutlinedButton(
                                onPressed: () async {
                                  bool sucess =
                                      await PurchaseInvoice.deleteItem(
                                          barcodeCtrl.text);
                                  if (sucess == true) {
                                    showToast(
                                      "Done",
                                    );
                                    setState(() {
                                      barcodeCtrl.text = "";
                                      sellPriceCtrl.text = "";
                                      purchasePriceCtrl.text = "";
                                      colorCtrl.text = "";
                                      sizeCtrl.text = "";
                                      modelCtrl.text = "";
                                      categoryCtrl.text = "";
                                    });
                                  } else {
                                    showToast(
                                      "Error",
                                    );
                                  }
                                },
                                child: Icon(Icons.delete),
                              ),
                            ),
                          ]),
                        ]),
                    Offstage(
                        offstage: row < 15 && row > 0 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 1 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 2 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 3 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 4 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 5 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 6 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 7 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 8 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 9 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 10 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 11 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 12 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                    Offstage(
                        offstage: row < 15 && row > 13 ? false : true,
                        child: PurchasesRows(
                          invoiceId: numberCtrl.text,
                        )),
                  ],
                )),
            SizedBox(
              height: size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: Row(
                children: [
                  Text(
                    "Total Price".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    "${Global.totalPurchasePrice}",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.dollarSign),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Cash".tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  SizedBox(
                    width: 80,
                    height: 40,
                    child: TextField(
                      onTap: () {
                        setState(() {
                          Global.totalPurchasePrice = Global.totalPurchasePrice;
                        });
                      },
                      onSubmitted: (val) {
                        setState(() {
                          formCashCtrl.text = val;
                        });
                      },
                      controller: formCashCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15, left: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: size.width * .1,
                    height: size.height * .05,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (formCashCtrl.text != Global.totalPurchasePrice) {
                          showToast(
                            "Wrong Cash".tr,
                          );
                        } else {
                          bool success = await PurchaseInvoice.submit(
                              numberCtrl.text, dateCtrl.text);
                          if (success) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => barcodePrint(
                                        invoicePurchaseId:
                                            int.parse(numberCtrl.text))));
                          } else {
                            showToast(
                              "Error".tr,
                            );
                          }
                        }
                      },
                      icon: Icon(Icons.confirmation_num),
                      label: Text("Submit".tr),
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
