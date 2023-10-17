import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/apiurl.dart';

class Checkrequestbyid {
  final String _url = base_url;
  List temp = [];
  request(data) async {
    var tempdata = {'userid': data};
    var fullurl = '$_url/checkrequestbyid';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(tempdata), headers: _setHeaders());
    var body = jsonDecode(res.body);
    if (body.isEmpty) {
      return [];
    } else {
      temp.add(body[0]);
      return temp;
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
