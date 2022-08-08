import 'package:flutter/material.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/model.dart';
import 'package:max/widgets/tableColumn.dart';

class GetModels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Model.getModel(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return RawScrollbar(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              // controller: ScrollController(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int i) {
                Model model = snapshot.data[i];
                return Center(
                    child: Column(children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(160.0),
                      children: [
                        TableRow(children: [
                          tableColumn(
                              label: CurrentUser.language == "en"
                                  ? model.categoryName!
                                  : model.categoryNameAr!),
                          tableColumn(label: model.code!)
                        ]),
                      ],
                    ),
                  ),
                ]));
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
