import 'package:flutter/material.dart';
import 'package:max/objects/purchaseInvoice.dart';
import 'package:max/widgets/tableColumn.dart';

class GetPurchaseReport extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetPurchaseReport({Key? key, required this.startDate , required this.endDate})
      : super(key: key);
  @override
  GetPurchaseReportState createState() => GetPurchaseReportState();
}

class GetPurchaseReportState extends State<GetPurchaseReport> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PurchaseInvoice.getPurchaseReport(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              PurchaseInvoice purchase = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(110.0),
                  children: [
                  TableRow(children: [
                          tableColumn(
                            label: purchase.id!,
                          ),
                          tableColumn(
                            label: purchase.date!,
                          ),
                          tableColumn(
                            label: purchase.items.length.toString(),
                          ),
                          tableColumn(
                            label: purchase.total!,
                          ),
                          tableColumn(
                            label: purchase.cash!,
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
