import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/variables.dart';
import 'currentUser.dart';

class LogOut {
  static Future<bool> logOut() async {
    var url = "${Variables.apiUrl}user/logout.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      if (resbody['status'] == 200) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
