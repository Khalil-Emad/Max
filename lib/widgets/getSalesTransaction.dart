import 'package:flutter/material.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/tableColumn.dart';
import '../objects/transaction.dart';

class GetSalesTransaction extends StatefulWidget {
  final String date;

  const GetSalesTransaction({Key? key, required this.date}) : super(key: key);
  @override
  GetSalesTransactionState createState() => GetSalesTransactionState();
}

class GetSalesTransactionState extends State<GetSalesTransaction> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Transaction.getSalesTransaction(widget.date),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Transaction transaction = snapshot.data[i];
              return Table(
                defaultColumnWidth: FixedColumnWidth(100.0),
                children: [
                  TableRow(children: [
                    tableColumn(
                        label: CurrentUser.language == "en"
                            ? "${transaction.transactionsType!}  #${transaction.id!}"
                            : "${transaction.transactionsTypeAr!}  #${transaction.id!}"),
                    tableColumn(label: transaction.cash!)
                  ]),
                ],
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
