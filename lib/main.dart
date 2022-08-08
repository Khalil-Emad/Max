import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:max/appTranslate/translation.dart';
import 'package:max/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:max/objects/currentUser.dart';
import 'package:max/screens/login.dart';
import 'package:oktoast/oktoast.dart';
import 'screens/home/main_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool logged = false;

  checkLogin() async {
    bool success = await CurrentUser.checkLogin();
    if (success) {
      setState(() {
        logged = true;
      });
    } else {
      setState(() {
        logged = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      backgroundColor: Colors.black.withOpacity(0.8),
      radius: 13.0,
      textStyle: const TextStyle(fontSize: 18.0),
      child: GetMaterialApp(
        translations: Translation(),
        locale: Locale("ar"),
        fallbackLocale: Locale("ar"),
        debugShowCheckedModeBanner: false,
        title: 'Max',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: logged ? MainScreen() : Login(),
      ),
    );
  }
}
