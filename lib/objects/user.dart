// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? password;
  String? mobile;
  String? email;
  String? active;

  Map toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'userName': userName,
        'secKey': password,
        'mobile': mobile,
        'email': email,
      };

  User.fromJson(Map json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
    mobile = json['mobile'];
    email = json['email'];
    active = json['active'];
  }

  clearUser() {
    id = '';
    userName = '';
    firstName = '';
    lastName = '';
    email = '';
    password = '';
  }

  static Future<bool> addUser(firstName, userName, pass) async {
    var url = "${Variables.apiUrl}user/addUser.php";
    var data = {
      'adminId': CurrentUser.id,
      'firstName': firstName,
      'lastName': "max",
      'userName': userName,
      'password': pass,
      'mobile': "01544799635",
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 1) {
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

  static Future<List<User>> getUser() async {
    List<User> users = [];
    var url = "${Variables.apiUrl}user/getUsers.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      users = List<User>.from(l.map((model) => User.fromJson(model)));

      return users;
    }
    showToast(
      resbody['msg'],
    );
    return users;
  }

  static Future<bool> editUser(id, firstName, userName, pass) async {
    var url = "${Variables.apiUrl}user/editUser.php";
    var data = {
      'adminId': CurrentUser.id,
      'userId': id,
      'firstName': firstName,
      'lastName': "max",
      'userName': userName,
      'password': pass,
      'mobile': "01155977856",
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

  static Future<bool> disableUser(id) async {
    var url = "${Variables.apiUrl}user/disable.php";
    var data = {
      'adminId': CurrentUser.id,
      'userId': id,
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
