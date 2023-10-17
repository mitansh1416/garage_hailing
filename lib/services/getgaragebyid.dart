import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/services/fillterworkshoplist.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant/apiurl.dart';
import 'package:http/http.dart' as http;

class Getworkshopdatabyid {
  final String _url = base_url;

  getdata(data, LatLng currentlocation) async {
    var temp = [];

    var fullurl = '$_url/getworkshopbyid';

    var res = await http.post(Uri.parse(fullurl),
        body: jsonEncode(data), headers: _setHeaders());

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      var distance = calculateDistance(
              double.parse(currentlocation.latitude.toString()),
              double.parse(currentlocation.longitude.toString()),
              double.parse(body[0]['latitude']),
              double.parse(body[0]['longitude']))
          .toStringAsFixed(1);
      temp.add(body[0]);
      temp[0]['distance'] = distance.toString();
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
