import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Getworkshopdata {
  final String _url = base_url;

  getdata() async {
    var fullurl = '$_url/getworkshopdata';

    var res = await http.get(Uri.parse(fullurl), headers: _setHeaders());
    List temp = [];
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      for (int i = 0; i < body.length; i++) {
        temp.add(body[i]);
      }

      return temp;
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
