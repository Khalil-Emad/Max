import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/selectedSetting.dart';
import 'package:max/widgets/responsive.dart';

import '../../../constants/constants.dart';
import '../screens/home/main_screen.dart';

class SettingButton extends StatefulWidget {
  @override
  SettingButtonState createState() => SettingButtonState();
}

class SettingButtonState extends State<SettingButton> {
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
            "Select Zone".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          CurrentUser.caseLogin == "admin"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          SelectedSetting.selectedSetting = "1";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        });
                      },
                      icon: Icon(Icons.person),
                      label: Text("Users".tr),
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
                          SelectedSetting.selectedSetting = "2";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        });
                      },
                      icon: Icon(Icons.category),
                      label: Text("Category".tr),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: Responsive.isMobile(context)
                                ? defaultPadding / 2
                                : defaultPadding),
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CurrentUser.caseLogin == "admin"
                  ? ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          SelectedSetting.selectedSetting = "3";
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainScreen()));
                        });
                      },
                      icon: Icon(Icons.model_training),
                      label: Text("Models".tr),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding * 1.5,
                            vertical: Responsive.isMobile(context)
                                ? defaultPadding / 2
                                : defaultPadding),
                      ),
                    )
                  : Container(),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedSetting.selectedSetting = "4";
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
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    SelectedSetting.selectedSetting = "5";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.person_outline),
                label: Text("Clients".tr),
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
                    SelectedSetting.selectedSetting = "6";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.person_outline),
                label: Text("Search Model".tr),
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
                    SelectedSetting.selectedSetting = "7";
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainScreen()));
                  });
                },
                icon: Icon(Icons.person_outline),
                label: Text("Item Transfer".tr),
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
