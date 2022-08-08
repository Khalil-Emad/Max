import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController ctrl;
  final String label;
  const TextFieldWidget({Key? key, required this.ctrl, required this.label})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        width: 180,
        height: 60,
        child: TextFormField(
          readOnly: widget.label == "Code".tr ? true : false,
          obscureText: widget.label == "Password".tr ? true : false,
          controller: widget.ctrl,
          decoration: InputDecoration(labelText: "${widget.label} "),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            return null;
          },
        ),
      ),
    );
  }
}
