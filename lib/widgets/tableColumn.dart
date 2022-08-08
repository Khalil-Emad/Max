import 'package:flutter/material.dart';
import 'package:get/get.dart';

class tableColumn extends StatefulWidget {
  final String label;
  const tableColumn({Key? key, required this.label}) : super(key: key);

  @override
  State<tableColumn> createState() => _tableColumnState();
}

class _tableColumnState extends State<tableColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        widget.label.tr,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      )
    ]);
  }
}
