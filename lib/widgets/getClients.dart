import 'package:flutter/material.dart';
import 'package:max/widgets/tableColumn.dart';
import '../constants/constants.dart';
import '../objects/client.dart';

class GetClients extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Client.getClient(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              Client client = snapshot.data[i];
              return Center(
                  child: Container(
                padding: EdgeInsets.all(defaultPadding),
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(130.0),
                  children: [
                    TableRow(children: [
                      tableColumn(
                        label: client.name!,
                      ),
                      tableColumn(
                        label: client.phone!,
                      ),
                    ]),
                  ],
                ),
              ));
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
