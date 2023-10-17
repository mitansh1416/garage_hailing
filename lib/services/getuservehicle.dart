import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:garage_hailing/constant/apiurl.dart';

class Getuservehicledata {
  final String _url = base_url;
  List temp = [];

  getdata(data) async {
    var fullurl = '$_url/getuservehicle';
    var fullurl2 = '$_url/getvehicletypebyid';
    var tempData = {'userid': data};
    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(tempData), headers: _setHeaders());
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      for (int i = 0; i < body.length; i++) {
        temp.add(body[i]);
        var res2 = await http.post(Uri.parse(fullurl2),
            body: jsonEncode({'id': body[i]['vehicletype']}),
            headers: _setHeaders());
        var body1 = jsonDecode(res2.body);
        temp[i]['vehicletypename'] = body1[0]['name'];
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
