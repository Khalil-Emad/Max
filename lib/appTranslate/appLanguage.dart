import 'dart:ui';
import 'package:get/get.dart';
import 'localStorage.dart';

class AppLanguage extends GetxController {
  var appLocale = 'en';
  @override
  Future<void> onInit() async {
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    // ignore: unnecessary_null_comparison
    appLocale = localStorage.getLanguage == null
        ? 'en'
        : await localStorage.getLanguage;
    Get.updateLocale(Locale(appLocale));
    update();
  }

  changeLanguage(String val) async {
    LocalStorage localStorage = LocalStorage();

    appLocale = val;
    localStorage.saveLangeuage(val);
    Get.updateLocale(Locale(appLocale));

  }
}
