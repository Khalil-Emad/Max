import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import '../constants/variables.dart';

class StoreType {
  String? id;
  String? nameEn;
  String? nameAr;
  StoreType();
  StoreType.fromJson(Map json) {
    id = json['id'];
    nameEn = json['nameEn'];
    nameAr = json['nameAr'];
  }

  static Future<List<StoreType>> getStoreTypes() async {
    List<StoreType> storeTypes = [];

    var url = "${Variables.apiUrl}stock/getStore.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody;
      storeTypes =
          List<StoreType>.from(l.map((model) => StoreType.fromJson(model)));
      return storeTypes;
    }
    return storeTypes;
  }

  static Future<bool> transfer(date, from, to, barcodes) async {
    var url = "${Variables.apiUrl}stock/transfer.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'date': date,
      'from': from,
      'to': to,
      'barcode': jsonEncode(barcodes),
    };
    var res = await http.post(Uri.parse(url), body: data);
    if (res.body.isNotEmpty) {
      json.decode(res.body);
      return true;
    }
    return false;
  }
}
