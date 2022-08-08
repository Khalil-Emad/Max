import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/getUser.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';

class Users extends StatefulWidget {
  @override
  UsersState createState() => UsersState();
}

class UsersState extends State<Users> {
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
                "Users".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              ButtonWidget(label: "Add User".tr, icon: Icons.add)
            ],
          ),
          SizedBox(
              width: size.width,
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(125.0),
                    children: [
                      TableRow(children: [
                        Column(children: [tableColumn(label: "First Name")]),
                        Column(children: [tableColumn(label: "User Name")]),
                        Column(children: [tableColumn(label: "")]),
                      ]),
                    ],
                  ),
                ),
                GetUsers(),
              ]))),
        ],
      ),
    );
  }
}
