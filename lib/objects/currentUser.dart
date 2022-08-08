import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import '../constants/variables.dart';

class CurrentUser {
  static String? id;
  static String? userName;
  static String? firstName;
  static String? lastName;
  static String? email;
  static String? password;
  static String? caseLogin;
  static String language = "ar";

  CurrentUser();

  static Map toJson() => {
        'id': id,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'secKey': password,
      };

  CurrentUser.fromJson(Map json) {
    CurrentUser.id = json['id'];
    CurrentUser.userName = json['userName'];
    CurrentUser.firstName = json['firstName'];
    CurrentUser.lastName = json['lastName'];
    CurrentUser.email = json['email'];
    CurrentUser.password = json['secKey'];
    CurrentUser.caseLogin = json['caseLogin'];
  }

  static clearUser() {
    CurrentUser.id = '';
    CurrentUser.userName = '';
    CurrentUser.firstName = '';
    CurrentUser.lastName = '';
    CurrentUser.email = '';
    CurrentUser.password = '';
  }

  static Future<bool> logIn(userName, pass) async {
    var url = "${Variables.apiUrl}user/login.php";
    var data = {
      'userName': userName,
      'password': pass,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 1) {
      CurrentUser.fromJson(resbody['data']);
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

  static Future<bool> checkLogin() async {
    var url = "${Variables.apiUrl}user/checkLogin.php";

    var res = await http.post(Uri.parse(url));
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
    }
    if (resbody['status'] == 200) {
      CurrentUser.fromJson(resbody['data']);

      return true;
    }
    return false;
  }
}
