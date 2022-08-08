import 'dart:convert';
import 'package:max/objects/currentUser.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import '../constants/variables.dart';
import '../constants/global.dart';

class SalesInvoice {
  String? id;
  String? categoryNameAr;
  String? categoryName;
  String? modelCode;
  String? size;
  String? color;
  String? purchasePrice;
  String? salePrice;
  String? barcode;
  String? total;
  String? cash;
  static String? SalesInvoiceId;
  static String? randCode;
  String? date;
  String? time;
  String? startDate;
  String? endDate;
  String? discount;
  String? totalSalesItemCount;
  String? inputTotal;
  String? tempSalesId;
   String? storeNameEn;
  String? storeNameAr;
  List<dynamic> items = [];

  SalesInvoice();

  Map toJson() => {
        'id': id,
        'barcode': barcode,
        'modelCode': modelCode,
        'size': size,
        'color': color,
        'purchasePrice': purchasePrice,
        'salePrice': salePrice,
      };

  SalesInvoice.fromJson(Map json) {
    id = json['id'];
    randCode = json['randCode'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    modelCode = json['modelCode'];
    size = json['size'];
    color = json['color'];
    salePrice = json['salePrice'];
    barcode = json['barcode'];
    items = json['item'];
    date = json['date'];
    total = json['total'];
    cash = json['cash'];
    discount = json['discount'];
  }
  SalesInvoice.fromJson1(Map json) {
    id = json['id'];
    total = json['total'];
    cash = json['cash'];
    date = json['date'];
    time = json['time'];
    discount = json['discount'];
    totalSalesItemCount = json['totalSalesItemCount'];
    inputTotal = json['inputTotal'];
  }
  SalesInvoice.fromJson3(Map json) {
    id = json['id'];
    randCode = json['randCode'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    modelCode = json['modelCode'];
    size = json['size'];
    color = json['color'];
    salePrice = json['salePrice'];
    barcode = json['barcode'];
    date = json['date'];
    total = json['total'];
    cash = json['cash'];
    discount = json['discount'];
    tempSalesId = json['tempSalesId'];
    storeNameEn = json['storeNameEn'];
    storeNameAr = json['storeNameAr'];
  }

  static Future<String> getSalesInvoiceNum() async {
    var url = "${Variables.apiUrl}invoiceSales/getInvoice.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    String num = '';
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      num = resbody['salesInvoiceId'].toString();
      Global.randCode = resbody['randCode'];
    }
    return num;
  }

  static Future<List<SalesInvoice>> getItem(barcode, invoiceId) async {
    List<SalesInvoice> items = [];
    var url = "${Variables.apiUrl}invoiceSales/getBarcodeStock.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'randCode': Global.randCode,
      'barcode': barcode,
      'invoiceSalesId': invoiceId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      Global.totalSalesPrice = "0";
      Global.totalSalesPrice = resbody['total'];

      Iterable l = resbody['item'];
      items = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson3(model)));
      showToast(
        resbody['msg'],
      );

      return items;
    } else if (resbody['status'] == 0) {
      Global.totalSalesPrice = resbody['total'];

      return items;
    } else {
      showToast(
        resbody['msg'],
      );
      return items;
    }
  }

  static Future<bool> deleteItem(barcode) async {
    var url = "${Variables.apiUrl}invoiceSales/remove.php";
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

  static Future<bool> submit(date, invoiceId, discount, name, mobile) async {
    var url = "${Variables.apiUrl}invoiceSales/submit.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'randCode': Global.randCode,
      'date': date,
      'invoiceSalesId': invoiceId,
      'discount': discount,
      'name': name,
      'phone': mobile,
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

  static Future<bool> getSalesReturn(invoiceId) async {
    var url = "${Variables.apiUrl}invoiceSales/return.php";
    var data = {
      "adminId": CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'invoiceSalesId': invoiceId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      showToast(
        resbody[CurrentUser.language == "en" ? 'msg' : "msgAr"],
      );
      return true;
    } else {
      showToast(
        resbody[CurrentUser.language == "en" ? 'msg' : "msgAr"],
      );
      return false;
    }
  }

  static Future<List<SalesInvoice>> getSalesReport(startDate, endDate) async {
    List<SalesInvoice> sales = [];
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

      Iterable l = resbody["sales"];
      sales = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson(model)));

      return sales;
    }

    return sales;
  }

  static Future<List<SalesInvoice>> getTotalSales(startDate, endDate) async {
    List<SalesInvoice> total = [];
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
      total = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson1(model)));

      return total;
    }

    return total;
  }

  static Future<List<SalesInvoice>> getInvoicePrint(invoiceSalesId) async {
    List<SalesInvoice> invoicePrint = [];
    var url = "${Variables.apiUrl}invoiceSales/getInvoicePrint.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'invoiceSalesId': invoiceSalesId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["DataSales"];
      invoicePrint = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson3(model)));

      return invoicePrint;
    }

    return invoicePrint;
  }

  static Future<List<SalesInvoice>> getInvoicePrintTotal(invoiceSalesId) async {
    List<SalesInvoice> invoicePrint = [];
    var url = "${Variables.apiUrl}invoiceSales/getInvoicePrint.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'invoiceSalesId': invoiceSalesId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["DataInvoice"];
      invoicePrint = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson1(model)));

      return invoicePrint;
    }

    return invoicePrint;
  }
}
