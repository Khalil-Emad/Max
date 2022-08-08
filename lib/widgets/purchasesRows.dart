import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max/objects/category.dart';
import 'package:max/objects/currentUser.dart';
import 'package:oktoast/oktoast.dart';

import '../objects/purchaseInvoice.dart';
import '../objects/model.dart';

class PurchasesRows extends StatefulWidget {
  final String invoiceId;

  const PurchasesRows({Key? key, required this.invoiceId}) : super(key: key);
  @override
  State<PurchasesRows> createState() => _PurchasesRowsState();
}

class _PurchasesRowsState extends State<PurchasesRows> {
  TextEditingController purchasePriceCtrl = TextEditingController();
  TextEditingController barcodeCtrl = TextEditingController();
  TextEditingController categoryCtrl = new TextEditingController();
  TextEditingController modelCtrl = new TextEditingController();
  TextEditingController sizeCtrl = new TextEditingController();
  TextEditingController colorCtrl = new TextEditingController();
  TextEditingController sellPriceCtrl = new TextEditingController();

  TextEditingController? formPriceCtrl, dateCtrl;

  Category? categoryValue;
  Model? modelValue;
  List<Category> categories = [];
  List<Model> models = [];

  getCategory() async {
    categories = await Category.getCategory();
    setState(() {
      categoryValue = categories[0];
      categoryCtrl.text = categoryValue!.id!;
    });
  }

  getModel() async {
    models = await Model.getModel();
    setState(() {
      modelValue = models[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
    getModel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
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
                            // PurchaseInvoice.totalPurchasePrice = "0";
                            categoryValue = newValue!;
                            categoryCtrl.text = categoryValue!.id!;
                          });
                        },
                        items: categories.map((Category category) {
                          return DropdownMenuItem<Category>(
                              value: category,
                              child: FittedBox(
                                  child: Text(CurrentUser.language == "en"
                                      ? category.categoryName!
                                      : category.categoryNameAr!)));
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
                        barcodeCtrl.text = await PurchaseInvoice.getBarcode(
                            categoryCtrl.text,
                            modelCtrl.text,
                            sizeCtrl.text,
                            colorCtrl.text,
                            purchasePriceCtrl.text,
                            sellPriceCtrl.text,
                            widget.invoiceId);
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
                          await PurchaseInvoice.deleteItem(barcodeCtrl.text);
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
      ],
    );
  }
}
