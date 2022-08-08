import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';
import 'currentUser.dart';

class CheckAdminPass {
  static Future<bool> checkAdminPass(pass) async {
    var url = "${Variables.apiUrl}user/checkPasswordAdmin.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'password': pass,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      if (resbody['status'] == 200) {
        showToast(resbody['msg']);
        return true;
      } else {
        showToast(resbody['msg']);
        return false;
      }
    }
    return false;
  }
}
