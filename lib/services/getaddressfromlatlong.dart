import 'dart:convert';

import 'package:http/http.dart' as http;

class LatLongToAddress {
  convert(double lat, double long) async {
    String apiurl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyAnVKwxamwf0s5e4wxT0HhqRj1lxPRlN-w";

    var res = await http.get(Uri.parse(apiurl));

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      Map firstresult = data["results"][0];
      String address = firstresult["formatted_address"];
      return address;
    }
  }
}
