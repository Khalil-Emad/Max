import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/transaction.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';

class Spending {
  String? id;
  String? name;
  String? nameAr;
  String? cash;
  String? date;
  String? status;
  String? transactionsType;
  String? totalSpending;

  Map toJson() => {
        'id': id,
        'name': name,
        'nameAr': nameAr,
      };

  Spending.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['nameAr'];
    cash = json['cash'];
    date = json['date'];
    transactionsType = json['transactionsType'];
    totalSpending = json['totalSpending'];
  }

  Spending.fromJson1(Map json) {
    id = json['spendingId'];
    name = json['name'];
    nameAr = json['nameAr'];
    cash = json['cash'];
    date = json['date'];
    status = json['spendingStatus'];
  }

  static Future<bool> addTypeSpending(name, nameAr) async {
    var url = "${Variables.apiUrl}spending/typeAdd.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'name': name,
      'nameAr': nameAr,
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

  static Future<List<Spending>> getTypeSpending() async {
    List<Spending> spendingTypeList = [];
    var url = "${Variables.apiUrl}spending/getType.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      spendingTypeList =
          List<Spending>.from(l.map((model) => Spending.fromJson(model)));

      return spendingTypeList;
    }
    showToast(
      resbody['msg'],
    );
    return spendingTypeList;
  }

  static Future<bool> addSpending(id, cash, date) async {
    var url = "${Variables.apiUrl}spending/add.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'spendingTypeId': id,
      'cash': cash,
      'date': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      if (resbody['status'] == 200) {
        showToast(
          resbody['msg'],
        );
        return true;
      }
    }
    showToast(
      resbody['msg'],
    );
    return false;
  }

  static Future<List<Spending>> getSpending() async {
    List<Spending> spendingList = [];
    var url = "${Variables.apiUrl}spending/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      spendingList =
          List<Spending>.from(l.map((model) => Spending.fromJson1(model)));

      return spendingList;
    }
    showToast(
      resbody['msg'],
    );
    return spendingList;
  }

  static Future<bool> editSpending(id, cash, date) async {
    var url = "${Variables.apiUrl}spending/update.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'spendingId': id,
      'cash': cash,
      'date': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      if (resbody ['status'] == 200) {
        showToast(
          resbody['msg'],
        );
        return true;
      }
    }
    showToast(
      resbody['msg'],
    );
    return false;
  }

  static Future<List<Transaction>> getSpendingTransaction(date) async {
    List<Transaction> spending = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      // 'date': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["spending"];
      spending =
          List<Transaction>.from(l.map((model) => Transaction.fromJson(model)));

      return spending;
    }

    return spending;
  }

  static Future<List<Spending>> getSpendingReport(startDate, endDate) async {
    List<Spending> spending = [];
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

      Iterable l = resbody["spending"];
      spending =
          List<Spending>.from(l.map((model) => Spending.fromJson(model)));

      return spending;
    }

    return spending;
  }

  static Future<bool> disableSpending(spendingId) async {
    var url = "${Variables.apiUrl}spending/disable.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'spendingId': spendingId,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      return true;
    }
    showToast(
      resbody['msg'],
    );
    return false;
  }

  static Future<List<Spending>> getTotalSpending(startDate, endDate) async {
    List<Spending> spending = [];
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
      spending =
          List<Spending>.from(l.map((model) => Spending.fromJson(model)));

      return spending;
    }

    return spending;
  }
}
