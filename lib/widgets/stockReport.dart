import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:max/widgets/getTotalStock.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';
import '../objects/currentUser.dart';
import '../objects/stock.dart';
import '../objects/storeTypes.dart';
import 'getStockReport.dart';

class StockReport extends StatefulWidget {
  @override
  StockReportState createState() => StockReportState();
}

class StockReportState extends State<StockReport> {
  TextEditingController stockTypeCtrl = TextEditingController();

  List<StoreType> storeTypes = [];
  StoreType? dropdownValue = StoreType();
  final format = DateFormat("yyyy-MM-dd");
  List<Stock> totals = [];

  getStock() async {
    storeTypes = await StoreType.getStoreTypes();
    setState(() {
      dropdownValue = storeTypes[2];
      stockTypeCtrl.text = dropdownValue!.id!;
    });
  }

  @override
  void initState() {
    super.initState();
    stockTypeCtrl.text = "3";
    getStock();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Store Report".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                width: 100,
              ),
              Row(
                children: [
                  Text(
                    "Store".tr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 80,
                    width: 180,
                    padding: EdgeInsets.all(13),
                    child: DropdownButtonFormField(
                      value: dropdownValue,
                      isExpanded: true,
                      onChanged: (StoreType? value) {
                        setState(() {
                          dropdownValue = value!;
                          stockTypeCtrl.text = dropdownValue!.id!;
                        });
                      },
                      // onSaved: (StoreType? value) {
                      //   setState(() {
                      //     dropdownValue = value!;
                      //     stockTypeCtrl.text = dropdownValue!.id!;
                      //   });
                      // },
                      items: storeTypes.map((StoreType val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            CurrentUser.language == "en"
                                ? val.nameEn!
                                : val.nameAr!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Table(
                      columnWidths: {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(3),
                        3: FlexColumnWidth(3),
                        4: FlexColumnWidth(2),
                        5: FlexColumnWidth(3),
                        6: FlexColumnWidth(2),
                        7: FlexColumnWidth(3.5),
                        8: FlexColumnWidth(3),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(children: [
                          tableColumn(
                            label: '#',
                          ),
                          tableColumn(
                            label: 'Barcode',
                          ),
                          tableColumn(
                            label: 'Stock',
                          ),
                          tableColumn(
                            label: 'Category',
                          ),
                          tableColumn(
                            label: 'Model',
                          ),
                          tableColumn(
                            label: 'Size',
                          ),
                          tableColumn(
                            label: 'Color',
                          ),
                          tableColumn(
                            label: 'Purchase Price',
                          ),
                          tableColumn(
                            label: 'Sell Price',
                          ),
                        ]),
                        TableRow(children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 30,
                              )
                            ],
                          ),
                        ]),
                      ]),
                  GetStockReport(
                    storeType: stockTypeCtrl.text,
                  )
                ],
              )),
          Divider(color: Colors.white),
          GetTotalsStock(
            storeType: stockTypeCtrl.text,
          )
        ],
      ),
    );
  }
}
