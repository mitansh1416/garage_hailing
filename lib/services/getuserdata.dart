import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Getuserdata {
  final String _url = base_url;

  getdata(data) async {
    var fullurl = '$_url/getuserdata';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    if (res.statusCode == 200) {
      List body = jsonDecode(res.body);
      if (body.isNotEmpty) {
        return body;
      } else {
        return [];
      }
    } else {
      Fluttertoast.showToast(msg: res.statusCode.toString());
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
