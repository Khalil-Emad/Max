import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:max/constants/global.dart';

import '../constants/variables.dart';

class Transaction {
  String? id;
  String? cash;
  String? transactionsType;
  String? transactionsTypeAr;
  String? totalPurchases;
  String? totalSpending;
  String inputTotal = "";
  String outputTotal = "";

  Transaction.fromJson(Map json) {
    id = json['id'];
    cash = json['cash'];
    transactionsType = json['transactionsType'];
    transactionsTypeAr = json['transactionsTypeAr'];
    totalPurchases = json['totalPurchases'];
    totalSpending = json['totalSpending'];
    inputTotal = json['inputTotal'];
    outputTotal = json['outputTotal'];
  }
  Transaction.fromJson1(Map json) {
    id = json['id'];
    cash = json['cash'];
    transactionsType = json['transactionsType'];
    transactionsTypeAr = json['transactionsTypeAr'];
  }

  static Future<List<Transaction>> getSalesTransaction(date) async {
    List<Transaction> sales = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': date,
      'endDate': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["sales"];
      sales = List<Transaction>.from(
          l.map((model) => Transaction.fromJson1(model)));

      return sales;
    }

    return sales;
  }

  static Future<List<Transaction>> getPurchaseTransaction(date) async {
    List<Transaction> purchases = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': date,
      'endDate': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody["purchases"];
      purchases = List<Transaction>.from(
          l.map((model) => Transaction.fromJson1(model)));

      return purchases;
    }

    return purchases;
  }

  static Future<List<Transaction>> getSpendingTransaction(date) async {
    List<Transaction> spending = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': date,
      'endDate': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);

      Iterable l = resbody["spending"];
      spending = List<Transaction>.from(
          l.map((model) => Transaction.fromJson1(model)));

      return spending;
    }

    return spending;
  }

  static Future<List<Transaction>> getTotalsTransaction(date) async {
    List<Transaction> total = [];
    var url = "${Variables.apiUrl}transaction/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'startDate': date,
      'endDate': date,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Global.currentCash = resbody['data'][0]['cash'];
      Iterable l = resbody["data"];
      total =
          List<Transaction>.from(l.map((model) => Transaction.fromJson(model)));

      return total;
    }

    return total;
  }
}
