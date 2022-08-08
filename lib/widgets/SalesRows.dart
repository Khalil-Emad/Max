import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../objects/salesInvoice.dart';

class SalesRows extends StatefulWidget {
  final String invoiceId;

  const SalesRows({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<SalesRows> createState() => _SalesRowsState();
}

class _SalesRowsState extends State<SalesRows> {
  TextEditingController barcodeCtrl = TextEditingController();

  String barcode = "0000";
  List<SalesInvoice> items = [];
  int row = 0;
  FocusNode? myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
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
                            barcode = val;
                          });

                          items = await SalesInvoice.getItem(
                              barcode, widget.invoiceId);
                          setState(() {
                            if (items.length != 0) {
                              items = items;
                              if (row < 4) {
                                row++;
                              }
                            } else {
                              showToast("This Item is Sold Before".tr);
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Barcode'.tr,
                        )),
                  ),
                ]),
                Column(children: [
                  Text(
                    items.isEmpty ? "" : items[0].categoryName!.tr,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
                Column(children: [
                  Text(
                    items.isEmpty ? "" : items[0].modelCode!,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
                Column(children: [
                  Text(
                    items.isEmpty ? "" : items[0].size!,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
                Column(children: [
                  Text(
                    items.isEmpty ? "" : items[0].color!.tr,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
                Column(children: [
                  Text(
                    items.isEmpty ? "" : items[0].salePrice!.tr,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  )
                ]),
                OutlinedButton(
                  onPressed: () async {
                    bool sucess =
                        await SalesInvoice.deleteItem(items[0].barcode);
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
      ],
    );
  }
}
