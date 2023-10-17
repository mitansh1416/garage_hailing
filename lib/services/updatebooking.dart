// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/apiurl.dart';

class updatebookingstatus {
  var url = '$base_url/updatebookingstatus';
  update(data) async {
    var res = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        'content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    var body = jsonDecode(res.body);
    if (body['status'] == true) {
      return true;
    } else {
      return false;
    }
  }
}
