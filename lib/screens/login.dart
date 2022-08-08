import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/screens/home/main_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../appTranslate/appLanguage.dart';
import '../widgets/signInContainer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController? userNameCtrl, passCtrl;
  @override
  void initState() {
    super.initState();
    userNameCtrl = TextEditingController();
    passCtrl = TextEditingController();
  }

  Widget _usernameWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: userNameCtrl,
          decoration: InputDecoration(
            labelText: 'UserName'.tr,
            labelStyle: TextStyle(
                color: Color.fromRGBO(173, 183, 192, 1),
                fontWeight: FontWeight.bold),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordWidget() {
    return Stack(
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          controller: passCtrl,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password'.tr,
            labelStyle: TextStyle(
                color: Color.fromRGBO(173, 183, 192, 1),
                fontWeight: FontWeight.bold),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _submitButton() {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GetBuilder<AppLanguage>(
            init: AppLanguage(),
            builder: (controller) => ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.red[800]!],
                [Colors.green[800]!]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: CurrentUser.language == "en" ? 0 : 1,
              totalSwitches: 2,
              labels: ['EN', 'AR'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  if (index == 0) {
                    CurrentUser.language = "en";
                  } else {
                    CurrentUser.language = "ar";
                  }
                  controller.changeLanguage(CurrentUser.language);
                  Get.updateLocale(Locale(CurrentUser.language));
                });
              },
            ),
          ),
          InkWell(
            onTap: () async {
              bool success = await CurrentUser.logIn(
                  userNameCtrl?.text.trim(), passCtrl?.text.trim());
              if (success == true) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainScreen()));
              }
            },
            child: SizedBox.fromSize(
              size: Size.square(150.0),
              child: ClipOval(
                child: Material(
                  color: Color.fromRGBO(76, 81, 93, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Login'.tr,
                        style: TextStyle(
                            color: Color.fromARGB(255, 15, 35, 81),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            height: 1.6),
                      ),
                      // Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
                height: MediaQuery.of(context).size.height * 0.50,
                child: SigninContainer()),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: height * .55),
                        _usernameWidget(),
                        SizedBox(height: 20),
                        _passwordWidget(),
                        SizedBox(height: 30),
                        _submitButton(),
                        SizedBox(height: height * .050),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
