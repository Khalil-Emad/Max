import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/modelSearchResult.dart';
import 'package:max/widgets/tableColumn.dart';

import '../../../constants/constants.dart';

class ModelSearch extends StatefulWidget {
  @override
  ModelSearchState createState() => ModelSearchState();
}

class ModelSearchState extends State<ModelSearch> {
  TextEditingController modelCtrl = TextEditingController();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Model Search".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: 200,
              ),
              SizedBox(
                width: size.width * .1,
                child: TextField(
                    controller: modelCtrl,
                    onSubmitted: (val) async {
                      setState(() {
                        modelCtrl.text = val;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Model Number'.tr,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: size.width,
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          tableColumn(
                            label: 'Barcode',
                          ),
                          tableColumn(
                            label: 'Stock',
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
                ),
                modelCtrl.text != ""
                    ? ModelSearchResult(
                        modelNumber: modelCtrl.text,
                      )
                    : Container(),
              ]))),
        ],
      ),
    );
  }
}
