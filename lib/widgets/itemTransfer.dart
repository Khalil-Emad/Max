import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/widgets/responsive.dart';
import 'package:oktoast/oktoast.dart';
import '../../../constants/constants.dart';
import '../constants/global.dart';
import '../objects/currentUser.dart';
import '../objects/storeTypes.dart';
import 'barcodeRow.dart';

class ItemTransfer extends StatefulWidget {
  @override
  ItemTransferState createState() => ItemTransferState();
}

class ItemTransferState extends State<ItemTransfer> {
  TextEditingController dateCtrl = TextEditingController();
  TextEditingController barcodeCtrl = TextEditingController();
  String dateVal = '';
  List<StoreType> storeTypes = [];
  StoreType? dropdownValue;
  StoreType? dropdownValue1;

  // ignore: unused_field
  String _valueToValidate = '';

  getStock() async {
    storeTypes = await StoreType.getStoreTypes();
    setState(() {
      dropdownValue = storeTypes[0];
      dropdownValue1 = storeTypes[1];
    });
  }

  @override
  void initState() {
    super.initState();
    dateCtrl = TextEditingController(text: DateTime.now().toString());
    getStock();
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Item Transfer".tr,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: 200,
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
                  onChanged: (val) => setState(() {
                    dateVal = val;
                    dateCtrl.text = dateVal;
                  }),
                  validator: (val) {
                    setState(() => _valueToValidate = val ?? '');
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text("From".tr),
              SizedBox(
                width: 10,
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
                      dropdownValue = value;
                    });
                  },
                  onSaved: (StoreType? value) {
                    setState(() {
                      dropdownValue = value;
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
              SizedBox(
                width: 150,
              ),
              Text("To".tr),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 80,
                width: 180,
                padding: EdgeInsets.all(13),
                child: DropdownButtonFormField(
                  value: dropdownValue1,
                  isExpanded: true,
                  onChanged: (StoreType? value) {
                    setState(() {
                      dropdownValue1 = value;
                    });
                  },
                  onSaved: (StoreType? value) {
                    setState(() {
                      dropdownValue1 = value;
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
          barcodeRow(),
          barcodeRow(),
          barcodeRow(),
          barcodeRow(),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 40,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    bool success = await StoreType.transfer(dateCtrl.text,
                        dropdownValue!.id, dropdownValue1!.id, Global.barcodes);
                    if (success) {
                      showToast(
                        "Done".tr,
                      );
                    } else {
                      showToast(
                        "Error".tr,
                      );
                    }
                    setState(() {
                      Global.barcodes = [];
                    });
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
            ],
          )
        ],
      ),
    );
  }
}
