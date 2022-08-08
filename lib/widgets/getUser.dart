import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/user.dart';
import 'package:max/widgets/buttonWidget.dart';

class GetUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: User.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              User user = snapshot.data[i];
              return Center(
                  child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Table(
                    defaultColumnWidth: FixedColumnWidth(130.0),
                    children: [
                      TableRow(children: [
                        Column(children: [
                          Text(user.firstName!,
                              style: TextStyle(fontStyle: FontStyle.italic))
                        ]),
                        Column(children: [
                          Text(user.userName!,
                              style: TextStyle(fontStyle: FontStyle.italic))
                        ]),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Column(children: [
                            Container(
                              width: 90,
                              height: 40,
                              child: ButtonWidget(
                                label: "Edit User".tr,
                                user: user,
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
