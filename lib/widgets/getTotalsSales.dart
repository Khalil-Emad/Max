import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/salesInvoice.dart';

class GetTotalsSales extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetTotalsSales(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  @override
  GetTotalsSalesState createState() => GetTotalsSalesState();
}

class GetTotalsSalesState extends State<GetTotalsSales> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SalesInvoice.getTotalSales(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              SalesInvoice total = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 60),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Count :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          total.totalSalesItemCount!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Cash :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          total.inputTotal!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
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
