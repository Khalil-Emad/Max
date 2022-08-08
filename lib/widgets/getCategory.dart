import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/constants/constants.dart';
import 'package:max/objects/category.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/tableColumn.dart';

class GetCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Category.getCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Category category = snapshot.data[i];
              return Center(
                  child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(130.0),
                  children: [
                    TableRow(children: [
                      tableColumn(
                          label: CurrentUser.language == "en"
                              ? category.categoryName!
                              : category.categoryNameAr!),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Column(children: [
                          Container(
                            width: 90,
                            height: 40,
                            child: ButtonWidget(
                              label: "Edit Category".tr,
                              category: category,
                              icon: Icons.edit,
                            ),
                          )
                        ]),
                      ),
                    ]),
                  ],
                ),
              ));
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
