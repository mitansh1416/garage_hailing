import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:garage_hailing/constant/apiurl.dart';

class CreateUserVehicle {
  final String _url = base_url;
  createuser(data) async {
    var fullurl = '$_url/createvehicle';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    var body = jsonDecode(res.body);

    if (body['status'] == true) {
      Fluttertoast.showToast(msg: "User Vehicle Added :) ");
      return true;
    } else {
      Fluttertoast.showToast(msg: "Error :) ");
      return false;
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
