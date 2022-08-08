import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/appTranslate/appLanguage.dart';
import 'package:max/objects/checkAdminPass.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/drawerSelectedIndex.dart';
import 'package:max/objects/logOut.dart';
import 'package:max/screens/login.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/textField.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../constants/constants.dart';
import '../constants/global.dart';
import '../objects/selectedSetting.dart';
import '../screens/home/main_screen.dart';
import 'drawer_list_title.dart';

class SideMenu extends StatefulWidget {
  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends State<SideMenu> {
  TextEditingController confirmationCashCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  logout() {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Confirm your Cash"),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Cash".tr),
                  Text(Global.currentCash),
                ],
              ),
              TextFieldWidget(
                ctrl: confirmationCashCtrl,
                label: 'Current Cash'.tr,
              ),
            ],
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                if (Global.currentCash == confirmationCashCtrl.text) {
                  bool success = await LogOut.logOut();
                  if (success) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                } else {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Row(
                          children: [
                            Text("Error".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Please Check Your Cash".tr),
                            SizedBox(
                              height: 20,
                            ),
                            Text("OR".tr,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Confirm Admin Password".tr),
                            TextFieldWidget(
                              ctrl: passCtrl,
                              label: 'Password'.tr,
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton.icon(
                            onPressed: () async {
                              bool success =
                                  await CheckAdminPass.checkAdminPass(
                                      passCtrl.text);
                              if (success) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              } else {}
                            },
                            icon: Icon(Icons.done),
                            label: Text("Confirm".tr),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical: Responsive.isMobile(context)
                                      ? defaultPadding / 2
                                      : defaultPadding),
                            ),
                          )
                        ],
                      );
                    },
                  );
                }
              },
              icon: Icon(Icons.done),
              label: Text("Confirm".tr),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding * 1.5,
                    vertical: Responsive.isMobile(context)
                        ? defaultPadding / 2
                        : defaultPadding),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(child: Image.asset("assets/images/logo.png")),
            DrawerListTile(
              title: "Home".tr,
              icon: Icons.dashboard,
              press: () {
                setState(() {
                  DrawerSelectedIndex.selectedIndex = "0";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            DrawerListTile(
              title: "Sales".tr,
              icon: Icons.currency_pound,
              press: () {
                setState(() {
                  DrawerSelectedIndex.selectedIndex = "1";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            DrawerListTile(
              title: "Sales Return".tr,
              icon: Icons.settings_backup_restore_sharp,
              press: () {
                setState(() {
                  DrawerSelectedIndex.selectedIndex = "2";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            CurrentUser.caseLogin == "admin"
                ? Container(
                    child: Column(
                      children: [
                        DrawerListTile(
                          title: "Purchases".tr,
                          icon: Icons.monetization_on_outlined,
                          press: () {
                            setState(() {
                              DrawerSelectedIndex.selectedIndex = "3";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            });
                          },
                        ),
                        DrawerListTile(
                          title: "Purchases Return".tr,
                          icon: Icons.settings_backup_restore_sharp,
                          press: () {
                            setState(() {
                              DrawerSelectedIndex.selectedIndex = "4";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            });
                          },
                        ),
                        DrawerListTile(
                          title: "Reports".tr,
                          icon: Icons.report,
                          press: () {
                            setState(() {
                              DrawerSelectedIndex.selectedIndex = "5";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()));
                            });
                          },
                        ),
                      ],
                    ),
                  )
                : Container(),
            DrawerListTile(
              title: "Store".tr,
              icon: Icons.store,
              press: () {
                setState(() {
                  DrawerSelectedIndex.selectedIndex = "6";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            DrawerListTile(
              title: "Setting".tr,
              icon: Icons.settings,
              press: () {
                setState(() {
                  SelectedSetting.selectedSetting = "";
                  DrawerSelectedIndex.selectedIndex = "7";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            DrawerListTile(
              title: "About US".tr,
              icon: Icons.send_to_mobile,
              press: () {
                setState(() {
                  DrawerSelectedIndex.selectedIndex = "8";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                });
              },
            ),
            DrawerListTile(
              title: "Log Out".tr,
              icon: Icons.logout,
              press: () {
                logout();
              },
            ),
            SizedBox(
              height: 20,
            ),
            GetBuilder<AppLanguage>(
              init: AppLanguage(),
              builder: (controller) => ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.red[800]!],
                  [Colors.green[800]!]
                ],
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                initialLabelIndex: CurrentUser.language == "en" ? 0 : 1,
                totalSwitches: 2,
                labels: ['EN', 'AR'],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    if (index == 0) {
                      CurrentUser.language = "en";
                    } else {
                      CurrentUser.language = "ar";
                    }
                    controller.changeLanguage(CurrentUser.language);
                    Get.updateLocale(Locale(CurrentUser.language));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
