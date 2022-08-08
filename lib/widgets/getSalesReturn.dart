import 'package:flutter/material.dart';
import 'package:max/objects/salesInvoice.dart';
import '../objects/currentUser.dart';

class GetSalesReturn extends StatefulWidget {
  final String invoiceId;

  GetSalesReturn({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<GetSalesReturn> createState() => GetSalesReturnState();
}

class GetSalesReturnState extends State<GetSalesReturn> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SalesInvoice.getInvoicePrint(widget.invoiceId),
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
                          Column(children: [
                            Text(
                              item.barcode!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ]),
                          Column(children: [
                            Text(
                              CurrentUser.language == "en"
                                  ? item.categoryName!
                                  : item.categoryNameAr!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ]),
                          Column(children: [
                            Text(
                              item.modelCode!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ]),
                          Column(children: [
                            Text(
                              item.size!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ]),
                          Column(children: [
                            Text(
                              item.color!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ]),
                          Column(children: [
                            Text(
                              item.salePrice!,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            )
                          ])
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
