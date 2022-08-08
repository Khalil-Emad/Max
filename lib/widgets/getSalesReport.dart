import 'package:flutter/material.dart';
import 'package:max/objects/salesInvoice.dart';
import 'package:max/widgets/tableColumn.dart';

class GetSalesReport extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetSalesReport(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  @override
  GetSalesReportState createState() => GetSalesReportState();
}

class GetSalesReportState extends State<GetSalesReport> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SalesInvoice.getSalesReport(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              SalesInvoice sales = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(110.0),
                  children: [
                    TableRow(children: [
                      tableColumn(
                        label: sales.id!,
                      ),
                      tableColumn(
                        label: sales.date!,
                      ),
                      tableColumn(
                        label: sales.items.length.toString(),
                      ),
                      tableColumn(
                        label: sales.total!,
                      ),
                      tableColumn(
                        label: sales.discount!,
                      ),
                      tableColumn(
                        label: sales.cash!,
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
