import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/widgets/buttonWidget.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/tableColumn.dart';
import 'package:max/widgets/textField.dart';

import '../../../constants/constants.dart';
import '../objects/spending.dart';
import 'getSpending.dart';

class SpendingScreen extends StatefulWidget {
  @override
  SpendingScreenState createState() => SpendingScreenState();
}

class SpendingScreenState extends State<SpendingScreen> {
  TextEditingController cashCtrl = TextEditingController();
  TextEditingController dateCtrl = TextEditingController();
  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  List<Spending> spendingList = [];
  Spending? dropdownValue;

  getSpending() async {
    spendingList = await Spending.getTypeSpending();
    setState(() {
      dropdownValue = spendingList[0];
    });
  }

  @override
  void initState() {
    super.initState();
    getSpending();
    dateCtrl = TextEditingController(text: DateTime.now().toString());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Spending".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: size.width * .15,
                height: 75,
                child: DateTimePicker(
                  dateMask: 'd MMM, yyyy',
                  controller: dateCtrl,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  icon: Icon(Icons.event),
                  dateLabelText: 'Date'.tr,
                  onChanged: (val) => setState(() => dateVal = val),
                  validator: (val) {
                    setState(() => _valueToValidate = val ?? '');
                    return null;
                  },
                ),
              ),
              ButtonWidget(label: "Add Spending".tr, icon: Icons.add)
            ],
          ),
          SizedBox(
              width: size.width,
              child: Center(
                  child: Column(children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        Column(children: [
                          tableColumn(
                            label: 'Select Spending'.tr,
                          ),
                        ]),
                        Column(children: [
                          tableColumn(
                            label: 'Cash'.tr,
                          ),
                        ]),
                        Column(children: [
                          Text('',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                      ]),
                      TableRow(children: [
                        Column(children: [
                          Container(
                            height: 80,
                            width: 180,
                            padding: EdgeInsets.all(13),
                            child: DropdownButtonFormField(
                              value: dropdownValue,
                              isExpanded: true,
                              onChanged: (Spending? value) {
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              onSaved: (Spending? value) {
                                setState(() {
                                  dropdownValue = value;
                                });
                              },
                              validator: (Spending? value) {
                                if (value == null) {
                                  return "Required".tr;
                                } else {
                                  return null;
                                }
                              },
                              items: spendingList.map((Spending val) {
                                return DropdownMenuItem(
                                  value: val,
                                  child: Text(
                                    CurrentUser.language == "en"
                                        ? val.name!
                                        : val.nameAr!,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ]),
                        Column(children: [
                          TextFieldWidget(
                            ctrl: cashCtrl,
                            label: 'Cash'.tr,
                          ),
                        ]),
                        Column(children: [
                          Container(
                            width: 140,
                            height: 40,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await Spending.addSpending(dropdownValue!.id,
                                    cashCtrl.text, dateCtrl.text);
                              },
                              icon: Icon(Icons.confirmation_num),
                              label: Text("Submit".tr),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: defaultPadding * 1.5,
                                    vertical: Responsive.isMobile(context)
                                        ? defaultPadding / 2
                                        : defaultPadding),
                              ),
                            ),
                          ),
                        ]),
                      ]),
                      TableRow(children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                            )
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Table(children: [
                    TableRow(children: [
                      Column(children: [
                        tableColumn(
                          label: 'Spending'.tr,
                        ),
                      ]),
                      Column(children: [
                        tableColumn(
                          label: 'Cash'.tr,
                        ),
                      ]),
                      Column(children: [
                        tableColumn(
                          label: 'Date'.tr,
                        ),
                      ]),
                      Column(children: [
                        tableColumn(
                          label: '',
                        ),
                      ]),
                    ]),
                  ]),
                ),
                GetSpending(),
              ]))),
        ],
      ),
    );
  }
}
