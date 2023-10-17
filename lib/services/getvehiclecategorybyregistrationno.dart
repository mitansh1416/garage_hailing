import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Getcategorybyregistrationno {
  final String _url = base_url;

  getdata(data) async {
    var fullurl = '$_url/getvehicletypebyregistrationno';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      return body[0]['vehicletype'];
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
