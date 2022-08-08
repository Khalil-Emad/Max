import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/category.dart';
import 'package:max/objects/client.dart';
import 'package:max/objects/spending.dart';
import 'package:max/widgets/responsive.dart';
import 'package:max/widgets/textField.dart';
import 'package:oktoast/oktoast.dart';
import '../constants/constants.dart';
import '../objects/currentUser.dart';
import '../objects/model.dart';
import '../objects/user.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final User? user;
  final Spending? spending;
  final Category? category;
  final IconData icon;
  const ButtonWidget(
      {Key? key,
      required this.label,
      this.user,
      this.spending,
      this.category,
      required this.icon})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  List<Category> categories = [];
  Category? dropdownValue;
  List<Spending> spendings = [];
  Spending? dropdownValueSpending;
  String dateVal = '';
  // ignore: unused_field
  String _valueToValidate = '';
  TextEditingController? firstNameCtrl,
      lastNameCtrl,
      userNameCtrl,
      passCtrl,
      mobileCtrl,
      categoryNameCtrl,
      clientNameCtrl,
      ClientPhoneCtrl,
      spendingNameCtrl,
      spendingNameArCtrl,
      spendingCashCtrl,
      spendingDateCtrl,
      codeCtrl,
      categoryNameArCtrl;

  getCategories() async {
    categories = await Category.getCategory();
    dropdownValue = categories[0];
  }

  getSpendings() async {
    // spendings.clear();
    // widget.spending==null?
    //  spendings = await Spending.getSpending():spendings[0] = widget.spending!;
    // spendings.first = widget.spending!;
    spendings = await Spending.getSpending();
    dropdownValueSpending = spendings[0];
  }

  @override
  void initState() {
    super.initState();
    codeCtrl = TextEditingController();
    getCategories();
    getSpendings();
    if (widget.label == "Add User".tr) {
      firstNameCtrl = TextEditingController();
      userNameCtrl = TextEditingController();
      passCtrl = TextEditingController();
    } else if (widget.label == "Edit User".tr) {
      firstNameCtrl = TextEditingController(text: "${widget.user!.firstName}");
      lastNameCtrl = TextEditingController(text: "${widget.user!.lastName}");
      userNameCtrl = TextEditingController(text: "${widget.user!.userName}");
      passCtrl = TextEditingController(text: "${widget.user!.password}");
      mobileCtrl = TextEditingController(text: "${widget.user!.mobile}");
    } else if ((widget.label == "Add Category".tr)) {
      categoryNameCtrl = TextEditingController();
      categoryNameArCtrl = TextEditingController();
    } else if ((widget.label == "Edit Category".tr)) {
      categoryNameCtrl =
          TextEditingController(text: "${widget.category!.categoryName}");
      categoryNameArCtrl =
          TextEditingController(text: "${widget.category!.categoryNameAr}");
    } else if ((widget.label == "Add Spending".tr)) {
      spendingNameCtrl = TextEditingController();
      spendingNameArCtrl = TextEditingController();
    } else if ((widget.label == "Add Client".tr)) {
      clientNameCtrl = TextEditingController();
      ClientPhoneCtrl = TextEditingController();
    } else if ((widget.label == "Edit Spending".tr)) {
      spendingCashCtrl =
          TextEditingController(text: "${widget.spending!.cash}");
      spendingDateCtrl =
          TextEditingController(text: "${widget.spending!.date}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OutlinedButton.icon(
      label: Text(widget.label),
      icon: Icon(widget.icon),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
            horizontal: defaultPadding / 2,
            vertical: Responsive.isMobile(context)
                ? defaultPadding / 2
                : defaultPadding),
      ),
      onPressed: () async {
        if (widget.label == "Disable User".tr ||
            widget.label == "Enable User".tr) {
          bool success = await User.disableUser(widget.user!.id);
          if (success == true) {
            showToast(
              widget.user!.active == "1"
                  ? "User Disabled".tr
                  : "User Enabled".tr,
            );
          }
        } else if (widget.label == "Disable Category".tr ||
            widget.label == "Enable Category".tr) {
          bool success = await Category.disableCategory(widget.category!.id);
          if (success == true) {
            showToast(
              widget.category!.active == "1"
                  ? "Category Disabled".tr
                  : "Category Enabled".tr,
            );
          }
        } else if (widget.label == "Disable Spending".tr ||
            widget.label == "Enable Spending".tr) {
          bool success = await Spending.disableSpending(widget.spending!.id);
          if (success == true) {
            showToast(
              widget.spending!.status == "0"
                  ? "Spending Disabled".tr
                  : "Spending Enabled".tr,
            );
          }
        } else {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.label),
                  ],
                ),
                content: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: widget.label == "Edit User".tr ||
                            widget.label == "Add User".tr
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFieldWidget(
                                ctrl: firstNameCtrl!,
                                label: 'First Name'.tr,
                              ),
                              TextFieldWidget(
                                ctrl: userNameCtrl!,
                                label: 'User Name'.tr,
                              ),
                              TextFieldWidget(
                                ctrl: passCtrl!,
                                label: 'Password'.tr,
                              ),
                              widget.label == "Edit User".tr
                                  ? Container(
                                      width: 150,
                                      height: 40,
                                      child: ButtonWidget(
                                        label: widget.user!.active == "1"
                                            ? "Disable User".tr
                                            : "Enable User".tr,
                                        user: widget.user,
                                        icon: widget.user!.active == "1"
                                            ? Icons.disabled_by_default
                                            : Icons.done,
                                      ),
                                    )
                                  : Container()
                            ],
                          )
                        : widget.label == "Add Category".tr ||
                                widget.label == "Edit Category".tr
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFieldWidget(
                                    ctrl: categoryNameCtrl!,
                                    label: 'Category Name'.tr,
                                  ),
                                  TextFieldWidget(
                                    ctrl: categoryNameArCtrl!,
                                    label: 'Arabic Name'.tr,
                                  ),
                                  widget.label == "Edit Category".tr
                                      ? Container(
                                          width: 110,
                                          height: 40,
                                          child: ButtonWidget(
                                            label:
                                                widget.category!.active == "1"
                                                    ? "Disable Category".tr
                                                    : "Enable Category".tr,
                                            category: widget.category,
                                            icon: widget.category!.active == "1"
                                                ? Icons.disabled_by_default
                                                : Icons.done,
                                          ),
                                        )
                                      : Container()
                                ],
                              )
                            : widget.label == "Edit Spending".tr
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 80,
                                        width: 180,
                                        padding: EdgeInsets.all(13),
                                        child: DropdownButtonFormField(
                                          value: dropdownValueSpending,
                                          isExpanded: true,
                                          onChanged: (Spending? value) {
                                            setState(() {
                                              dropdownValueSpending = value;
                                            });
                                          },
                                          onSaved: (Spending? value) {
                                            setState(() {
                                              dropdownValueSpending = value;
                                            });
                                          },
                                          validator: (Spending? value) {
                                            if (value == null) {
                                              return "Required".tr;
                                            } else {
                                              return null;
                                            }
                                          },
                                          items: spendings.map((Spending val) {
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
                                      TextFieldWidget(
                                        ctrl: spendingCashCtrl!,
                                        label: 'Cash'.tr,
                                      ),
                                      SizedBox(
                                        width: size.width * .15,
                                        height: 75,
                                        child: DateTimePicker(
                                          dateMask: 'd MMM, yyyy',
                                          controller: spendingDateCtrl,
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2100),
                                          icon: Icon(Icons.event),
                                          dateLabelText: 'Date'.tr,
                                          onChanged: (val) =>
                                              setState(() => dateVal = val),
                                          validator: (val) {
                                            setState(() =>
                                                _valueToValidate = val ?? '');
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 110,
                                        height: 40,
                                        child: ButtonWidget(
                                          label: widget.spending!.status == "0"
                                              ? "Disable Spending".tr
                                              : "Enable Spending".tr,
                                          spending: widget.spending,
                                          icon: widget.spending!.status == "0"
                                              ? Icons.disabled_by_default
                                              : Icons.done,
                                        ),
                                      )
                                    ],
                                  )
                                : widget.label == "Add Model".tr
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: Text(
                                                        "Select Category".tr)),
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  child:
                                                      DropdownButtonFormField(
                                                    value: dropdownValue,
                                                    isExpanded: true,
                                                    onChanged:
                                                        (Category? value) {
                                                      setState(() {
                                                        dropdownValue = value;
                                                      });
                                                    },
                                                    onSaved: (Category? value) {
                                                      setState(() {
                                                        dropdownValue = value;
                                                      });
                                                    },
                                                    validator:
                                                        (Category? value) {
                                                      if (value == null) {
                                                        return "Required".tr;
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    items: categories
                                                        .map((Category val) {
                                                      return DropdownMenuItem(
                                                        value: val,
                                                        child: Text(
                                                          CurrentUser.language ==
                                                                  "en"
                                                              ? val
                                                                  .categoryName!
                                                              : val
                                                                  .categoryNameAr!,
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                    height: 80,
                                                    width: 90,
                                                    child:
                                                        Text("Model Code".tr)),
                                                Container(
                                                  height: 80,
                                                  width: 200,
                                                  child: TextFieldWidget(
                                                    ctrl: codeCtrl!,
                                                    label: 'Code'.tr,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ])
                                    : widget.label == "Add Client".tr
                                        ? Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFieldWidget(
                                                ctrl: clientNameCtrl!,
                                                label: 'Client Name'.tr,
                                              ),
                                              TextFieldWidget(
                                                ctrl: ClientPhoneCtrl!,
                                                label: 'Mobile'.tr,
                                              ),
                                            ],
                                          )
                                        : widget.label == "Add Spending".tr
                                            ? Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFieldWidget(
                                                    ctrl: spendingNameCtrl!,
                                                    label: 'English Name'.tr,
                                                  ),
                                                  TextFieldWidget(
                                                    ctrl: spendingNameArCtrl!,
                                                    label: 'Arabic Name'.tr,
                                                  ),
                                                ],
                                              )
                                            : Column()),
                actions: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (widget.label == "Add User".tr) {
                        bool success = await User.addUser(
                          firstNameCtrl?.text.trim(),
                          userNameCtrl?.text.trim(),
                          passCtrl?.text.trim(),
                        );
                        if (success == true) {
                          showToast(
                            "User Added".tr,
                          );
                        }
                      } else if (widget.label == "Edit User".tr) {
                        bool success = await User.editUser(
                          widget.user!.id,
                          firstNameCtrl?.text.trim(),
                          userNameCtrl?.text.trim(),
                          passCtrl?.text.trim(),
                        );
                        if (success == true) {
                          showToast("Edit Successfully".tr);
                        }
                      } else if (widget.label == "Add Category".tr) {
                        bool success = await Category.addCategory(
                            categoryNameCtrl?.text.trim(),
                            categoryNameArCtrl?.text.trim());
                        if (success == true) {
                          showToast("Category Added".tr);
                        } else {
                          showToast("Something Wrong".tr);
                        }
                      } else if (widget.label == "Edit Category".tr) {
                        bool success = await Category.editCategory(
                          widget.category!.id,
                          categoryNameCtrl?.text.trim(),
                          categoryNameArCtrl?.text.trim(),
                        );
                        if (success == true) {
                          showToast("Edit Successfully".tr);
                        }
                      } else if (widget.label == "Add Model".tr) {
                        String success = await Model.addModel(dropdownValue);
                        setState(() {
                          codeCtrl!.text = success;
                        });
                      } else if (widget.label == "Add Client".tr) {
                        await Client.addClient(clientNameCtrl?.text.trim(),
                            ClientPhoneCtrl?.text.trim());
                      } else if (widget.label == "Add Spending".tr) {
                        await Spending.addTypeSpending(
                          spendingNameCtrl?.text.trim(),
                          spendingNameArCtrl?.text.trim(),
                        );
                      } else if (widget.label == "Edit Spending".tr) {
                        await Spending.editSpending(
                          dropdownValueSpending!.id,
                          spendingCashCtrl!.text.trim(),
                          spendingDateCtrl!.text.trim(),
                        );
                      }
                    },
                    icon: widget.label == "Add User".tr ||
                            widget.label == "Add Category".tr ||
                            widget.label == "Add Client".tr ||
                            widget.label == "Add Spending".tr
                        ? Icon(Icons.add)
                        : Icon(Icons.edit),
                    label: widget.label == "Add User".tr
                        ? Text("Add User".tr)
                        : widget.label == "Edit User".tr
                            ? Text("Edit User".tr)
                            : widget.label == "Add Category".tr
                                ? Text("Add Category".tr)
                                : widget.label == "Add Model".tr
                                    ? Text("Add Model".tr)
                                    : widget.label == "Add Client".tr
                                        ? Text("Add Client".tr)
                                        : widget.label == "Add Spending".tr
                                            ? Text("Add Spending".tr)
                                            : widget.label == "Edit Spending".tr
                                                ? Text("Edit Spending".tr)
                                                : Text("Edit Category".tr),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: Responsive.isMobile(context)
                              ? defaultPadding / 2
                              : defaultPadding),
                    ),
                  )
                ],
              );
            },
          );
        }
      },
    );
  }
}
