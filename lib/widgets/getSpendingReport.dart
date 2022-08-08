import 'package:flutter/material.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/spending.dart';
import 'package:max/widgets/tableColumn.dart';

class GetSpendingReport extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetSpendingReport(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  @override
  GetSpendingReportState createState() => GetSpendingReportState();
}

class GetSpendingReportState extends State<GetSpendingReport> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Spending.getSpendingReport(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Spending spending = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(110.0),
                  children: [
                    TableRow(children: [
                      tableColumn(
                        label: spending.id!,
                      ),
                      tableColumn(
                        label: spending.date!,
                      ),
                      tableColumn(
                        label: CurrentUser.language == "en"
                            ? spending.name!
                            : spending.nameAr!,
                      ),
                      tableColumn(
                        label: spending.cash!,
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
