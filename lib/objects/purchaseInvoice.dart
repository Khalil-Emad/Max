import 'dart:convert';
import 'package:max/objects/currentUser.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import '../constants/global.dart';
import '../constants/variables.dart';

class PurchaseInvoice {
  String? id;
  String? categoryName;
  String? categoryNameAr;
  String? modelCode;
  String? size;
  String? color;
  String? purchasePrice;
  String? salePrice;
  String? barcode;
  String? total;
  String? cash;
  String? invoicePurchasesId;
  static String? randCode;
  String? date;
  String? totalPurchasesCount;
  String? totalPurchases;
  List<dynamic> items = [];

  Map toJson() => {
        'id': id,
        'categoryName': categoryName,
        'categoryNameAr': categoryNameAr,
        'modelCode': modelCode,
        'size': size,
        'color': color,
        'purchasePrice': purchasePrice,
        'salePrice': salePrice,
      };

  PurchaseInvoice.fromJson(Map json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    modelCode = json['modelCode'];
    size = json['size'];
    color = json['color'];
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    barcode = json['barcode'];
    items = json['item'];
    date = json['date'];
    total = json['total'];
    cash = json['cash'];
  }
  PurchaseInvoice.fromJson1(Map json) {
    id = json['id'];
    total = json['total'];
    cash = json['cash'];
    date = json['date'];
    totalPurchasesCount = json['totalPurchasesCount'];
    totalPurchases = json['totalPurchases'];
  }
  PurchaseInvoice.fromJson3(Map json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    modelCode = json['modelCode'];
    size = json['size'];
    color = json['color'];
    purchasePrice = json['purchasePrice'];
    salePrice = json['salePrice'];
    barcode = json['barcode'];
    date = json['date'];
    total = json['total'];
    cash = json['cash'];
  }

  static Future getPurchaseInvoiceNum() async {
    var url = "${Variables.apiUrl}invoicePurchases/getInvoice.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    String num = '';
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      num = resbody['invoiceId'].toString();

      Global.randCode = resbody['randCode'];
    }
    return num;
  }

  static Future<String> getBarcode(
      category, model, size, color, purchasePrice, salePrice, invoiceId) async {
    var url = "${Variables.apiUrl}invoicePurchases/getBarcodeTemp.php";
    String barcodeVal = '';
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'categoryId': category,
      'model': model,
      'size': size,
      'color': color,
      'salePrice': salePrice,
      'purchasePrice': purchasePrice,
      'invoicePurchasesId': invoiceId,
      'randCode': Global.randCode,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      showToast(
        resbody['msg'],
      );
      Global.totalPurchasePrice = "0";
      barcodeVal = resbody["data"]["barcode"];
      Global.totalPurchasePrice = resbody["data"]["totalPurchasePrice"];
      return barcodeVal;
    } else {
      barcodeVal = "";
      showToast(
        resbody['msg'],
      );
      return barcodeVal;
    }
  }

  static Future<bool> submit(invoiceId, date) async {
    var url = "${Variables.apiUrl}invoicePurchases/submit.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'randCode': Global.randCode,
      'date': date,
      'invoicePurchasesId': invoiceId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      showToast(
        resbody['msg'],
      );
      return true;
    } else {
      showToast(
        resbody['msg'],
      );
      return false;
    }
  }

  static Future<List<PurchaseInvoice>> getPurchaseReturn(
      invoiceId, returnCase, type) async {
    List<PurchaseInvoice> items = [];
    List<PurchaseInvoice> invoiceData = [];
    var url = "${Variables.apiUrl}invoicePurchases/return.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'invoicePurchasesId': invoiceId,
      'returnCase': returnCase,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      if (type == "1") {
        Iterable l = resbody["DataInvoice"];
        invoiceData = List<PurchaseInvoice>.from(
            l.map((model) => PurchaseInvoice.fromJson1(model)));

        return invoiceData;
      } else {
        Iterable l = resbody["DataPurchases"];
        items = List<PurchaseInvoice>.from(
            l.map((model) => PurchaseInvoice.fromJson3(model)));
        showToast(
          resbody['msg'],
        );
        return items;
      }
    } else {
      showToast(
        resbody['msg'],
      );
      return items;
    }
  }

  static Future<List<PurchaseInvoice>> getPurchaseReport(
      startDate, endDate) async {
    List<PurchaseInvoice> purchases = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': startDate,
      'endDate': endDate,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody["purchases"];
      purchases = List<PurchaseInvoice>.from(
          l.map((model) => PurchaseInvoice.fromJson(model)));

      return purchases;
    }

    return purchases;
  }

  static Future<List<PurchaseInvoice>> getTotalPurchase(
      startDate, endDate) async {
    List<PurchaseInvoice> total = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': startDate,
      'endDate': endDate,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["data"];
      total = List<PurchaseInvoice>.from(
          l.map((model) => PurchaseInvoice.fromJson1(model)));

      return total;
    }

    return total;
  }

  static Future<bool> deleteItem(barcode) async {
    var url = "${Variables.apiUrl}invoicePurchases/remove.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
       'barcode': barcode,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      return true;
    } else {
      return false;
    }
  }
}
