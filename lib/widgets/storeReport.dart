import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:max/widgets/tableColumn.dart';
import '../../../constants/constants.dart';
import '../objects/currentUser.dart';
import '../objects/stock.dart';
import '../objects/storeTypes.dart';
import 'getStoreReport.dart';
import 'getTotalStore.dart';

class StoreReport extends StatefulWidget {
  @override
  StoreReportState createState() => StoreReportState();
}

class StoreReportState extends State<StoreReport> {
  TextEditingController? startDateCtrl, endDateCtrl;
  TextEditingController stockTypeCtrl = TextEditingController();

  List<Stock> totals = [];
  List<StoreType> storeTypes = [];
  StoreType? dropdownValue ;

  getStock() async {
    storeTypes = await StoreType.getStoreTypes();
    setState(() {
      dropdownValue = storeTypes[2];
    });
  }

  @override
  void initState() {
    super.initState();
      stockTypeCtrl.text = "3";
    getStock();
    startDateCtrl = TextEditingController(text: DateTime.now().toString());
    endDateCtrl = TextEditingController(text: DateTime.now().toString());
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
                      onSaved: (StoreType? value) {
                        setState(() {
                          dropdownValue = value!;
                          stockTypeCtrl.text = dropdownValue!.id!;

                        });
                      },
                      validator: (StoreType? value) {
                        if (value == null) {
                          return "Required".tr;
                        } else {
                          return null;
                        }
                      },
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
                        2: FlexColumnWidth(2),
                        3: FlexColumnWidth(2),
                        4: FlexColumnWidth(2.5),
                        5: FlexColumnWidth(2),
                        6: FlexColumnWidth(3.5),
                        7: FlexColumnWidth(3.5),
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
                        ]),
                      ]),
                  GetStoreReport(
                    storeType: stockTypeCtrl.text,
                  )
                ],
              )),
          Divider(color: Colors.white),
          GetTotalStore(
            storeType: stockTypeCtrl.text,
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
