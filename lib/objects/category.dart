import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';

class Category {
  String? id;
  String? categoryName;
  String? categoryNameAr;
  String? active;

  Map toJson() => {
        'id': id,
        'categoryName': categoryName,
        'categoryNameAr': categoryNameAr,
      };

  Category.fromJson(Map json) {
    id = json['id'];
    categoryName = json['categoryName'];
    categoryNameAr = json['categoryNameAr'];
    active = json['active'];
  }

  clearCategory() {
    id = '';
    categoryName = '';
    categoryNameAr = '';
  }

  static Future<bool> addCategory(name, nameAr) async {
    var url = "${Variables.apiUrl}category/add.php";
    var data = {
      'adminId': CurrentUser.id,
      'categoryName': name,
      'categoryNameAr': nameAr,
      'caseLogin': CurrentUser.caseLogin,
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

  static Future<List<Category>> getCategory() async {
    List<Category> Categories = [];
    var url = "${Variables.apiUrl}category/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      Categories =
          List<Category>.from(l.map((model) => Category.fromJson(model)));

      return Categories;
    }
    showToast(
      resbody['msg'],
    );
    return Categories;
  }

  static Future<bool> editCategory(id, categoryName, categoryNameAr) async {
    var url = "${Variables.apiUrl}category/update.php";
    var data = {
      'adminId': CurrentUser.id,
      'categoryId': id,
      'categoryName': categoryName,
      'categoryNameAr': categoryNameAr,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      if (resbody['status'] == 200) {
        return true;
      }
    }
    showToast(
      resbody['msg'],
    );
    return false;
  }

  static Future<bool> disableCategory(id) async {
    var url = "${Variables.apiUrl}category/disable.php";
    var data = {
      'adminId': CurrentUser.id,
      'categoryId': id,
      'caseLogin': CurrentUser.caseLogin,
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
}
