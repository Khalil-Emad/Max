import 'package:max/objects/drawerSelectedIndex.dart';
import 'package:max/screens/dashbord/purchaseScreen.dart';
import 'package:max/screens/dashbord/salesScreen.dart';
import 'package:max/screens/dashbord/storeScreen.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/screens/dashbord/dashboardScreen.dart';
import 'package:flutter/material.dart';

import '../../widgets/aboutUs.dart';
import '../../widgets/sideMenu.dart';
import '../dashbord/purchaseReturnScreen.dart';
import '../dashbord/reports.dart';
import '../dashbord/salesReturnScreen.dart';
import '../dashbord/setting.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      // drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: DrawerSelectedIndex.selectedIndex == "0"
                    ? DashbordScreen()
                    : DrawerSelectedIndex.selectedIndex == "1"
                        ? SalesScreen()
                        : DrawerSelectedIndex.selectedIndex == "2"
                            ? SalesReturnScreen()
                            : DrawerSelectedIndex.selectedIndex == "3"
                                ? PurchaseScreen()
                                : DrawerSelectedIndex.selectedIndex == "4"
                                    ? PurchaseReturnScreen()
                                    : DrawerSelectedIndex.selectedIndex == "5"
                                        ? Reports()
                                        : DrawerSelectedIndex.selectedIndex ==
                                                "6" 
                                            ? StoreScreen()
                                            : DrawerSelectedIndex
                                                        .selectedIndex ==
                                                    "7"
                                                ? Setting()
                                            : DrawerSelectedIndex
                                                        .selectedIndex ==
                                                    "8"
                                                ? AboutUs()
                                                : Container()),
          ],
        ),
      ),
    );
  }
}
