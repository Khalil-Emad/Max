import 'package:get_storage/get_storage.dart';

class LocalStorage {
  void saveLangeuage(String language) async {
    await GetStorage().write('lang', language);
  }

  Future<String> get getLanguage async {
    return await GetStorage().read('lang');
  }

  
}
