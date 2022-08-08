import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import '../constants/variables.dart';

class Stock {
  String? id;
  String? categoryName;
  String? categoryNameAr;
  String? barcode;
  String? codeModel;
  String? size;
  String? color;
  String? purchasePrice;
  String? salePrice;
  String totalSalePrice = "";
  String? totalPurchasePrice;
  String? expectedProfit;
  String? storeNameEn;
  String? storeNameAr;

  Stock.fromJson(Map json) {
    id = json['id'];
    barcode = json['barcode'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    codeModel = json['codeModel'];
    size = json['size'];
    color = json['color'];
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    storeNameEn = json['storeNameEn'];
    storeNameAr = json['storeNameAr'];
  }

  Stock.fromJson1(Map json) {
    id = json['id'];

    totalSalePrice = json['totalSalePrice'];
    totalPurchasePrice = json['totalPurchasePrice'];
    expectedProfit = json['expectedProfit'];
  }

  static Future<List<dynamic>> getStock(storeType) async {
    List<dynamic> zero = [];
    List<dynamic> three = [];
    List<dynamic> stock = [];
    var url = "${Variables.apiUrl}stock/report.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'stockType': storeType,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["zero"];
      zero = List<Stock>.from(l.map((model) => Stock.fromJson(model)));
      Iterable i = resbody["three"];
      three = List<Stock>.from(i.map((model) => Stock.fromJson(model)));

      stock = zero + three;
      return stock;
    }

    return stock;
  }

  static Future<List<Stock>> getTotalStock(storeType) async {
    List<Stock> total = [];
    var url = "${Variables.apiUrl}stock/report.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'stockType': storeType,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable i = resbody["total"];
      total = List<Stock>.from(i.map((model) => Stock.fromJson1(model)));

      return total;
    }

    return total;
  }
}
