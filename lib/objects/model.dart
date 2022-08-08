import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:max/objects/salesInvoice.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';

class Model {
  String? id;
  String? categoryName;
  String? categoryNameAr;
  String? code;

  Model.fromJson(Map json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    code = json['code'];
  }

  clearCategory() {
    id = '';
    categoryName = '';
    code = '';
  }

  static Future<String> addModel(category) async {
    var url = "${Variables.apiUrl}model/add.php";
    var data = {
      'adminId': CurrentUser.id,
      'categoryId': category.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      showToast(
        "Done",
      );
      return resbody['msg'];
    } else {
      showToast(
        resbody['msg'],
      );
      return "";
    }
  }

  static Future<List<Model>> getModel() async {
    List<Model> models = [];
    var url = "${Variables.apiUrl}model/getAll.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      models = List<Model>.from(l.map((model) => Model.fromJson(model)));

      return models;
    }
    showToast(
      resbody['msg'],
    );
    return models;
  }

  static Future<List<SalesInvoice>> searchModel(modelCode) async {
    List<SalesInvoice> models = [];
    var url = "${Variables.apiUrl}model/searchModel.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'model': modelCode,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      models = List<SalesInvoice>.from(
          l.map((model) => SalesInvoice.fromJson3(model)));

      return models;
    }
    showToast(
      resbody['msg'],
    );
    return models;
  }
}
