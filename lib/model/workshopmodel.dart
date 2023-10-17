// ignore_for_file: non_constant_identifier_names

class Workshopmodel {
  String? id;
  String? shop_name;
  String? address_1;
  String? latitude;
  String? longitude;
  String? phone_number;
  String? distance;
  String? vehicle_category_id;
  String? registrationno;
  String? service;
  Workshopmodel({
    this.id,
    this.shop_name,
    this.address_1,
    this.latitude,
    this.longitude,
    this.phone_number,
    this.distance,
    this.vehicle_category_id,
    this.registrationno,
    this.service,
  });

  Workshopmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop_name = json['shop_name'];
    address_1 = json['address_1'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone_number = json['phone_number'];
    distance = json['distance'];
    vehicle_category_id = json['vehicle_category_id'];
    registrationno = json['registrationno'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_name'] = shop_name;
    data['address_1'] = address_1;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone_number'] = phone_number;
    data['distance'] = distance;
    data['vehicle_category_id'] = vehicle_category_id;
    data['registrationno'] = registrationno;
    data['service'] = service;
    return data;
  }
}
