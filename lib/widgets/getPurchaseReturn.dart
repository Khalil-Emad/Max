import 'package:flutter/material.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/purchaseInvoice.dart';

class GetPurchaseReturn extends StatefulWidget {
  final String invoiceId;
  GetPurchaseReturn({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<GetPurchaseReturn> createState() => GetPurchaseReturnState();
}

class GetPurchaseReturnState extends State<GetPurchaseReturn> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PurchaseInvoice.getPurchaseReturn(widget.invoiceId, "0","2"),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              PurchaseInvoice item = snapshot.data[i];
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
                              item.purchasePrice!,
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
