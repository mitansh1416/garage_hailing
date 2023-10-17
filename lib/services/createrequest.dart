import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constant/apiurl.dart';

class CreateRequest {
  final String _url = base_url;
  request(data) async {
    var fullurl = '$_url/createrequest';
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());
    var body = jsonDecode(res.body);
    if (body['status'] == true) {
      return 'true';
    } else {
      return 'false';
    }
  }

  _setHeaders() => {
        'content-type': 'application/json',
        'Accept': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "*",
      };
}
