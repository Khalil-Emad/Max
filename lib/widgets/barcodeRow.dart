import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/global.dart';

class barcodeRow extends StatefulWidget {
  const barcodeRow({Key? key}) : super(key: key);

  @override
  State<barcodeRow> createState() => _barcodeRowState();
}

class _barcodeRowState extends State<barcodeRow> {
  TextEditingController barcodeCtrl = TextEditingController();
  TextEditingController barcodeCtrl1 = TextEditingController();
  TextEditingController barcodeCtrl2 = TextEditingController();
  TextEditingController barcodeCtrl3 = TextEditingController();
  TextEditingController barcodeCtrl4 = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  FocusNode myFocusNode1 = FocusNode();
  FocusNode myFocusNode2 = FocusNode();
  FocusNode myFocusNode3 = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Row(
      children: [
        SizedBox(
          width: size.width * .08,
          child: TextField(
              controller: barcodeCtrl,
              autofocus: true,
              onSubmitted: (val) {
                setState(() {
                  barcodeCtrl.text = val.trim();
                  Global.barcodes.add(barcodeCtrl.text);
                });
                myFocusNode.requestFocus();

              },
            
              decoration: InputDecoration(
                hintText: 'Barcode'.tr,
              )),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width * .08,
          child: TextField(
              controller: barcodeCtrl1,
              autofocus: true,
              focusNode: myFocusNode,
              onSubmitted: (val) {
                setState(() {
                  barcodeCtrl1.text = val.trim();
                  Global.barcodes.add(barcodeCtrl1.text);
                });
                myFocusNode1.requestFocus();
              },
              
              decoration: InputDecoration(
                hintText: 'Barcode'.tr,
              )),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width * .08,
          child: TextField(
              controller: barcodeCtrl2,
              autofocus: true,
              focusNode: myFocusNode1,
              onSubmitted: (val) {
                setState(() {
                  barcodeCtrl2.text = val.trim();
                  Global.barcodes.add(barcodeCtrl2.text);
                });
                myFocusNode2.requestFocus();

              },
              decoration: InputDecoration(
                hintText: 'Barcode'.tr,
              )),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width * .08,
          child: TextField(
              controller: barcodeCtrl3,
              autofocus: true,
              focusNode: myFocusNode2,
              onSubmitted: (val) {
                setState(() {
                  barcodeCtrl3.text = val.trim();
                  Global.barcodes.add(barcodeCtrl3.text);
                });
              },
              onEditingComplete: () {
                myFocusNode3.requestFocus();
              },
              decoration: InputDecoration(
                hintText: 'Barcode'.tr,
              )),
        ),
        SizedBox(width: 20),
        SizedBox(
          width: size.width * .08,
          child: TextField(
              controller: barcodeCtrl4,
              autofocus: true,
              focusNode: myFocusNode3,
              onSubmitted: (val) async {
                setState(() {
                  barcodeCtrl4.text = val.trim();
                  Global.barcodes.add(barcodeCtrl4.text);
                });
              },
              decoration: InputDecoration(
                hintText: 'Barcode'.tr,
              )),
        ),
      ],
    );
  }
}
