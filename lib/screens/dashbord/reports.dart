import 'package:max/constants/constants.dart';
import 'package:max/objects/selectedReport.dart';
import 'package:max/widgets/header.dart';
import 'package:max/widgets/purchasesReport.dart';
import 'package:max/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:max/widgets/stockReport.dart';
import '../../widgets/reportsButton.dart';
import '../../widgets/salesReport.dart';
import '../../widgets/spendingReport.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);
  @override
  ReportsState createState() => ReportsState();
}

class ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Header(),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SelectedReport.selectedReport == "0"
                            ? SalesReport()
                            : SelectedReport.selectedReport == "1"
                                ? PurchasesReport()
                                : SelectedReport.selectedReport == "2"
                                    ? StockReport()
                                    : SelectedReport.selectedReport == "3"
                                        ? SpendingReport()
                                        : Container(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) ReportsButtom(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: ReportsButtom(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
