import 'package:get/get.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/drawerSelectedIndex.dart';
import 'package:max/widgets/responsive.dart';
import 'package:flutter/material.dart';

import 'profile_card.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // if (!Responsive.isDesktop(context))
        // IconButton(
        //     icon: Icon(Icons.menu),
        //     onPressed: context.read<MenuController>().controlMenu),
        if (!Responsive.isMobile(context))
          Text(
            DrawerSelectedIndex.selectedIndex == "0"
                ? "Home".tr
                : DrawerSelectedIndex.selectedIndex == "1"
                    ? "Sales".tr
                    : DrawerSelectedIndex.selectedIndex == "2"
                        ? "Sales Return".tr
                        : DrawerSelectedIndex.selectedIndex == "3"
                            ? "Purchases".tr
                            : DrawerSelectedIndex.selectedIndex == "4"
                                ? "Purchases Return".tr
                                : DrawerSelectedIndex.selectedIndex == "5"
                                    ? "Reports".tr
                                    : DrawerSelectedIndex.selectedIndex == "6"
                                        ? "Store".tr
                                        : DrawerSelectedIndex.selectedIndex ==
                                                "7"
                                            ? "Setting".tr
                                            : "",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        if (Responsive.isMobile(context)) SizedBox(width: defaultPadding),
        // Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}
