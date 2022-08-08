import 'package:flutter/material.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/tableColumn.dart';

import '../objects/stock.dart';

class GetStoreReport extends StatefulWidget {
  final String storeType;

  const GetStoreReport({Key? key, required this.storeType}) : super(key: key);
  @override
  GetStoreReportState createState() => GetStoreReportState();
}

class GetStoreReportState extends State<GetStoreReport> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Stock.getStock(widget.storeType),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Stock item = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(3),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(2),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(2),
                    6: FlexColumnWidth(2),
                    7: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(children: [
                      tableColumn(
                        label: item.id!,
                      ),
                      tableColumn(
                        label: CurrentUser.language == "en"
                            ? item.storeNameEn!
                            : item.storeNameAr!,
                      ),
                      tableColumn(
                        label: item.barcode!,
                      ),
                      tableColumn(
                        label: CurrentUser.language == "en"
                            ? item.categoryName!
                            : item.categoryNameAr!,
                      ),
                      tableColumn(
                        label: item.codeModel!,
                      ),
                      tableColumn(
                        label: item.size!,
                      ),
                      tableColumn(
                        label: item.color!,
                      ),
                      tableColumn(
                        label: item.salePrice!,
                      ),
                    ]),
                  ],
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
