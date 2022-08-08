import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/tableColumn.dart';

import '../../../constants/constants.dart';
import 'GetClients.dart';

class Clients extends StatefulWidget {
  @override
  ClientsState createState() => ClientsState();
}

class ClientsState extends State<Clients> {
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
                "Clients".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ButtonWidget(label: "Add Client".tr, icon: Icons.add)
            ],
          ),
          SizedBox(
              width: size.width,
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  // margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(170.0),
                    children: [
                      TableRow(children: [
                        tableColumn(label: 'Client Name'.tr),
                        tableColumn(label: 'Mobile'.tr),
                      ]),
                    ],
                  ),
                ),
                GetClients(),
              ]))),
        ],
      ),
    );
  }
}
