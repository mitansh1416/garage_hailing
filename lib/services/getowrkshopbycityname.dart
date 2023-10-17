import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Getworkshopdatabycityname {
  final String _url = base_url;

  getdata(data) async {
    var fullurl = '$_url/getworkshopbycityname';

    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      if (body.isEmpty) {
        return [];
      } else {
        return body;
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
