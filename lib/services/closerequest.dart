import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../constant/apiurl.dart';

class CloseRequest {
  final String _url = base_url;
  closerequest(data) async {
    var fullurl = '$_url/updaterequest';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    var body = jsonDecode(res.body);
    if (body['status'] == true) {
      Fluttertoast.showToast(msg: "Request Closed  ");
    } else {
      Fluttertoast.showToast(msg: "Error :) ");
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
