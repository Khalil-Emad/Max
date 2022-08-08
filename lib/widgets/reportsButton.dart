// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/selectedReport.dart';
import 'package:max/widgets/responsive.dart';

import '../../../constants/constants.dart';
import '../screens/home/main_screen.dart';

class ReportsButtom extends StatefulWidget {
  @override
  ReportsButtomState createState() => ReportsButtomState();
}

class ReportsButtomState extends State<ReportsButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Report".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedReport.selectedReport = "0";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.sell),
                label: Text("Sales".tr),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: Responsive.isMobile(context)
                          ? defaultPadding / 2
                          : defaultPadding),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedReport.selectedReport = "1";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.scale_outlined),
                label: Text("Purchases".tr),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: Responsive.isMobile(context)
                          ? defaultPadding / 2
                          : defaultPadding),
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedReport.selectedReport = "2";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.store),
                label: Text("Stock".tr),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: Responsive.isMobile(context)
                          ? defaultPadding / 2
                          : defaultPadding),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedReport.selectedReport = "3";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.event_busy),
                label: Text("Spending".tr),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: Responsive.isMobile(context)
                          ? defaultPadding / 2
                          : defaultPadding),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
