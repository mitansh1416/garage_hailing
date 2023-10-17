// ignore_for_file: non_constant_identifier_names

import 'dart:math';
import 'package:garage_hailing/services/getaddressfromlatlong.dart';
import 'package:garage_hailing/services/getowrkshopbycityname.dart';
import 'package:garage_hailing/services/getvehiclecategorybyregistrationno.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

fillterworkshoplist(LatLng currentlocation, double distance,
    String registrationno, String selectedservice) async {
  String address = await LatLongToAddress()
      .convert(currentlocation.latitude, currentlocation.longitude);
  var templist = address.split(',');

  String temp_cityname = templist[templist.length - 3];

  String cityname = temp_cityname.trimLeft();

  List temp = await Getworkshopdatabycityname().getdata({'city': cityname});

  List workshop_city_fillterd = [];
  for (int i = 0; i < temp.length; i++) {
    workshop_city_fillterd.add(temp[i]);
  }

  List fillterd_workshop_list_distance = [];
  List final_workshop_list = [];
  List temp2 = [];
  if (workshop_city_fillterd.isNotEmpty) {
    for (int i = 0; i < workshop_city_fillterd.length; i++) {
      if (workshop_city_fillterd[i]['latitude'] != null &&
          workshop_city_fillterd[i]['longitude'] != null) {
        workshop_city_fillterd[i]['distance'] = calculateDistance(
                double.parse(currentlocation.latitude.toString()),
                double.parse(currentlocation.longitude.toString()),
                double.parse(workshop_city_fillterd[i]['latitude']),
                double.parse(workshop_city_fillterd[i]['longitude']))
            .toStringAsFixed(1);
        fillterd_workshop_list_distance.add(workshop_city_fillterd[i]);
      }
    }

    for (int j = 0; j < fillterd_workshop_list_distance.length; j++) {
      if (double.parse(fillterd_workshop_list_distance[j]['distance']) <=
          distance) {
        temp2.add(fillterd_workshop_list_distance[j]);
      }
    }
    var vehicletype = await Getcategorybyregistrationno()
        .getdata({'registrationno': registrationno});
    for (int k = 0; k < temp2.length; k++) {
      if (temp2[k]['vehicle_category_id'] == vehicletype) {
        final_workshop_list.add(temp2[k]);
      }
    }
    for (int l = 0; l < final_workshop_list.length; l++) {
      final_workshop_list[l]['registrationno'] = registrationno;
      final_workshop_list[l]['service'] = selectedservice;
    }

    return final_workshop_list;
  } else {
    return [];
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var a = 0.5 -
      cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
