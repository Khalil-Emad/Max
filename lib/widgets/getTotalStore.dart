import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/stock.dart';

class GetTotalStore extends StatefulWidget {
  final String storeType;

  const GetTotalStore(
      {Key? key, required this.storeType})
      : super(key: key);
  @override
  GetTotalStoreState createState() => GetTotalStoreState();
}

class GetTotalStoreState extends State<GetTotalStore> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Stock.getTotalStock( widget.storeType),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Stock total = snapshot.data[i];
              return Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20, left: 60),
                child: Row(
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
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
