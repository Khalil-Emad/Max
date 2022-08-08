import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../objects/transaction.dart';

class GetTotalsTransaction extends StatefulWidget {
  final String date;

  const GetTotalsTransaction({Key? key, required this.date}) : super(key: key);
  @override
  GetTotalsTransactionState createState() => GetTotalsTransactionState();
}

class GetTotalsTransactionState extends State<GetTotalsTransaction> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Transaction.getTotalsTransaction(widget.date),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Transaction transaction = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Input Total :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          transaction.inputTotal,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Output Total :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          transaction.outputTotal,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Cash :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          transaction.cash!,
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
