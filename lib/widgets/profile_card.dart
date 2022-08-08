import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 38,
          ),
          Responsive.isMobile(context)
              ? SizedBox(width: defaultPadding / 2)
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  child:
                      Text("${CurrentUser.firstName} ${CurrentUser.lastName}"),
                ),
          // Icon(Icons.keyboard_arrow_down)
        ],
      ),
    );
  }
}
