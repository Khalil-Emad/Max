// ignore_for_file: file_names

import 'package:max/constants/constants.dart';
import 'package:max/widgets/categories.dart';
import 'package:max/widgets/header.dart';
import 'package:max/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:max/widgets/spending.dart';
import 'package:max/widgets/users.dart';
import '../../objects/selectedSetting.dart';
import '../../widgets/clients.dart';
import '../../widgets/itemTransfer.dart';
import '../../widgets/modelSearch.dart';
import '../../widgets/models.dart';
import '../../widgets/settingButton.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Header(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SelectedSetting.selectedSetting == "0"
                            ? Container()
                            : SelectedSetting.selectedSetting == "1"
                                ? Users()
                                : SelectedSetting.selectedSetting == "2"
                                    ? Categories()
                                    : SelectedSetting.selectedSetting == "3"
                                        ? Models()
                                        : SelectedSetting.selectedSetting == "4"
                                            ? SpendingScreen()
                                            : SelectedSetting.selectedSetting ==
                                                    "5"
                                                ? Clients()
                                                : SelectedSetting
                                                            .selectedSetting ==
                                                        "6"
                                                    ? ModelSearch()
                                                    : SelectedSetting
                                                                .selectedSetting ==
                                                            "7"
                                                        ? ItemTransfer()
                                                        : Container(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: SettingButton(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
