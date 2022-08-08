import 'package:flutter/material.dart';
import 'package:max/objects/model.dart';
import 'package:max/objects/salesInvoice.dart';
import 'package:max/widgets/tableColumn.dart';

import '../objects/currentUser.dart';

class ModelSearchResult extends StatefulWidget {
  final String modelNumber;

  ModelSearchResult({Key? key, required this.modelNumber}) : super(key: key);

  @override
  State<ModelSearchResult> createState() => ModelSearchResultState();
}

class ModelSearchResultState extends State<ModelSearchResult> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Model.searchModel(widget.modelNumber),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              SalesInvoice item = snapshot.data[i];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          tableColumn(label: item.barcode!),
                           tableColumn(
                        label: CurrentUser.language == "en"
                            ? item.storeNameEn!
                            : item.storeNameAr!,
                      ),
                          tableColumn(
                              label: CurrentUser.language == "en"
                                  ? item.categoryName!
                                  : item.categoryNameAr!),
                          tableColumn(label: item.modelCode!),
                          tableColumn(label: item.size!),
                          tableColumn(label: item.color!),
                          tableColumn(label: item.salePrice!),
                        ]),
                      ]),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
