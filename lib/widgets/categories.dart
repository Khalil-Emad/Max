import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/getCategory.dart';
import 'package:max/widgets/tableColumn.dart';

import '../../../constants/constants.dart';

class Categories extends StatefulWidget {
  @override
  CategoriesState createState() => CategoriesState();
}

class CategoriesState extends State<Categories> {
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
                "Categories".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ButtonWidget(label: "Add Category".tr, icon: Icons.add)
            ],
          ),
          SizedBox(
              width: size.width,
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(170.0),
                    children: [
                      TableRow(children: [
                        tableColumn(label: 'Category Name'.tr),
                        tableColumn(label: '')

                        // Column(children: [
                        //   Text('Category Name Ar',
                        //       style: TextStyle(
                        //           fontStyle: FontStyle.italic,
                        //           fontWeight: FontWeight.bold,
                        //           fontSize: 16))
                        // ]),
                      ]),
                    ],
                  ),
                ),
                GetCategories(),
              ]))),
        ],
      ),
    );
  }
}
