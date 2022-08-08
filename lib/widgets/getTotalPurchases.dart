import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/purchaseInvoice.dart';

class GetTotalsPurchases extends StatefulWidget {
  final String startDate;
  final String endDate;

  const GetTotalsPurchases({Key? key, required this.startDate , required this.endDate}) : super(key: key);
  @override
  GetTotalsPurchasesState createState() => GetTotalsPurchasesState();
}

class GetTotalsPurchasesState extends State<GetTotalsPurchases> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PurchaseInvoice.getTotalPurchase(widget.startDate, widget.endDate),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              PurchaseInvoice total = snapshot.data[i];
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
                          total.totalPurchasesCount!,
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
                          total.totalPurchases!,
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
