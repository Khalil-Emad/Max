import 'package:flutter/material.dart';
import 'package:max/widgets/tableColumn.dart';
import '../objects/currentUser.dart';
import '../objects/transaction.dart';

class GetPurchaseTransaction extends StatefulWidget {
  final String date;

  const GetPurchaseTransaction({Key? key, required this.date})
      : super(key: key);
  @override
  GetPurchaseTransactionState createState() => GetPurchaseTransactionState();
}

class GetPurchaseTransactionState extends State<GetPurchaseTransaction> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Transaction.getPurchaseTransaction(widget.date),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Transaction transaction = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(120.0),
                  children: [
                    TableRow(children: [
                      tableColumn(
                          label: CurrentUser.language == "en"
                              ? "${transaction.transactionsType!}  #${transaction.id!}"
                              : "${transaction.transactionsTypeAr!}  #${transaction.id!}"),
                      tableColumn(label: transaction.cash!)
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
