import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Editvehicle {
  final String _url = base_url;
  var temp = [];
  edit(data) async {
    var fullurl = '$_url/editvehicle';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    if (res.statusCode == 200) {
      Fluttertoast.showToast(msg: "User Vehilce Edited ");

      return true;
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
