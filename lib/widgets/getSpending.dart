import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/tableColumn.dart';

import '../objects/spending.dart';

class GetSpending extends StatefulWidget {
  @override
  GetSpendingState createState() => GetSpendingState();
}

class GetSpendingState extends State<GetSpending> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Spending.getSpending(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Spending spending = snapshot.data[i];
              return Center(
                  child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        tableColumn(
                            label: CurrentUser.language == "en"
                                ? spending.name!
                                : spending.nameAr!),
                        tableColumn(label: spending.cash!),
                        tableColumn(label: spending.date!),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(children: [
                            Container(
                              width: 120,
                              height: 40,
                              child: ButtonWidget(
                                label: "Edit Spending".tr,
                                spending: spending,
                                icon: Icons.edit,
                              ),
                            )
                          ]),
                        ),
                      ]),
                    ],
                  ),
                ),
              ]));
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
