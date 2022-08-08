import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/stock.dart';

class GetTotalsStock extends StatefulWidget {
  final String storeType;

  const GetTotalsStock({Key? key, required this.storeType}) : super(key: key);
  @override
  GetTotalsStockState createState() => GetTotalsStockState();
}

class GetTotalsStockState extends State<GetTotalsStock> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Stock.getTotalStock(widget.storeType),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Stock total = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 60),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Purchase Price :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          total.totalPurchasePrice!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Sell Price :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          total.totalSalePrice,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Expected Profit :".tr,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          total.expectedProfit!,
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
