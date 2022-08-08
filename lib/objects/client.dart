import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:max/objects/currentUser.dart';
import 'package:oktoast/oktoast.dart';

import '../constants/variables.dart';

class Client {
  String? id;
  String? name;
  String? phone;

  Map toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
      };

  Client.fromJson(Map json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }


  static Future<bool> addClient(clientName, clientPhone) async {
    var url = "${Variables.apiUrl}client/add.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
      'name': clientName,
      'phone': clientPhone,
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

  static Future<List<Client>> getClient() async {
    List<Client> clients = [];
    var url = "${Variables.apiUrl}client/get.php";
    var data = {
      'adminId': CurrentUser.id,
      'caseLogin': CurrentUser.caseLogin,
    };
    var res = await http.post(Uri.parse(url), body: data);
    var resbody;
    if (res.body.isNotEmpty) {
      resbody = json.decode(res.body);
      Iterable l = resbody;
      clients =
          List<Client>.from(l.map((model) => Client.fromJson(model)));

      return clients;
    }
    showToast(
      resbody['msg'],
    );
    return clients;
  }

}
