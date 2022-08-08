import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/spending.dart';

class GetTotalsSpending extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetTotalsSpending(
      {Key? key, required this.startDate, required this.endDate})
      : super(key: key);
  @override
  GetTotalsSpendingState createState() => GetTotalsSpendingState();
}

class GetTotalsSpendingState extends State<GetTotalsSpending> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Spending.getTotalSpending(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Spending total = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 60),
                child: Column(
                  children: [
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
                          total.totalSpending!,
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
