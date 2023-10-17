// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_hailing/constant/other.dart';

import 'package:garage_hailing/constant/services.dart';
import 'package:garage_hailing/constant/userdetails.dart';
import 'package:garage_hailing/routes/routes.dart';

import 'package:garage_hailing/services/checkrequestbyid.dart';
import 'package:garage_hailing/services/closerequest.dart';
import 'package:garage_hailing/services/createrequest.dart';
import 'package:garage_hailing/services/fillterworkshoplist.dart';
import 'package:garage_hailing/services/getaddressfromlatlong.dart';

import 'package:garage_hailing/services/getservicesoffered.dart';
import 'package:garage_hailing/services/getuservehicle.dart';
import 'package:garage_hailing/services/getvehiclemodel.dart';
import 'package:garage_hailing/services/googlemapsdirection.dart';
import 'package:garage_hailing/services/updaterequest.dart';

import 'package:garage_hailing/widgets/sidemenu.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../model/workshopmodel.dart';
import '../../services/getgaragebyid.dart';
import '../../services/gethailingservicestatus.dart';
import '../GLOBAL WIDGET/multiselectservice.dart';

class HomeMobile extends StatefulWidget {
  const HomeMobile({Key? key}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  var temp3;
  bool _isLoading1 = true;
  bool _isloading2 = false;
  bool _vehiclecount = true;
  late Timer timer;
  List data_vehicle = [];
  List data_vehicle_dropdown = [];
  List model = [];

  List<String> data_service = [];
  String selected_vehicle = '';
  List selected_service = [];
  String service_Selected = 'No service selected';
  getservicesoffered() async {
    List temp = await Getservicedata().getdata();
    setState(() {
      for (int i = 0; i < temp.length; i++) {
        data_service.add(temp[i]['servicename']);
      }
    });
  }

  Future getvehiclename() async {
    List temp = await Getuservehicledata().getdata(userid);
    List temp1 = [];

    setState(() {
      for (int i = 0; i < temp.length; i++) {
        data_vehicle.add(temp[i]['registrationno']);
      }
    });

    if (data_vehicle.length <= 1) {
      for (int i = 0; i < temp.length; i++) {
        temp1.add(await Getmodelbyregistrationno()
            .getdata({'registrationno': temp[i]['registrationno']}));
      }
      setState(() {
        model.add(temp1);
        _vehiclecount = false;
      });
    } else {
      for (int i = 0; i < temp.length; i++) {
        data_vehicle_dropdown
            .add('${temp[i]['model']}-${temp[i]['registrationno']}');
      }
    }
  }

  LatLng showLocation = const LatLng(0, 0);
  BitmapDescriptor markerbitmap = BitmapDescriptor.defaultMarker;
  BitmapDescriptor gargaebitmap_green = BitmapDescriptor.defaultMarker;
  BitmapDescriptor gargaebitmap_grey = BitmapDescriptor.defaultMarker;

  Future<void> markerinit() async {
    BitmapDescriptor bitmap_garage_g = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/garagegreen.png",
    );
    BitmapDescriptor bitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/location.png",
    );
    BitmapDescriptor bitmap_garage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/garage.png",
    );
    setState(() {
      markerbitmap = bitmap;
      gargaebitmap_grey = bitmap_garage;
      gargaebitmap_green = bitmap_garage_g;
    });
  }

  String Address = '';

  List<Workshopmodel> datag = [];
  List<Workshopmodel> datagbyid = [];
  late Timer mytimer;
  @override
  void initState() {
    super.initState();
    cameraPosition = const CameraPosition(target: LatLng(0, 0), zoom: 20.0);

    getvehiclename();
    _getUserLocation();
    getservicesoffered();
    markerinit();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    Address =
        await LatLongToAddress().convert(position.latitude, position.longitude);

    BitmapDescriptor bitmap = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/images/location.png",
    );

    Future<void> declaremapcontroller() async {
      await mapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }

    setState(() {
      markerbitmap = bitmap;
      showLocation = LatLng(position.latitude, position.longitude);

      cameraPosition = CameraPosition(target: showLocation, zoom: 13.0);
      declaremapcontroller();
      markers.add(Marker(
        markerId: const MarkerId('1'),
        position: showLocation, //position of marker
        infoWindow: const InfoWindow(
          title: 'Current Location',
        ),
        icon: markerbitmap, //Icon for Marker
      ));
    });
  }

  late GoogleMapController mapController;

  late CameraPosition cameraPosition;
  Set<Marker> markers = {};

  bool _isShown = true;
  bool _isshown3 = false;
  bool _isShown2 = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              markers: markers,
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
                mapController.animateCamera(
                    CameraUpdate.newCameraPosition(cameraPosition));
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      Center(
                        child: IconButton(
                            icon: const Icon(
                              Icons.menu,
                              size: 25,
                              color: Colors.black,
                            ),
                            onPressed: (() =>
                                _scaffoldkey.currentState?.openDrawer())),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Center(
                            child: Text(
                              Address,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 360,
              ),
              Column(
                children: [
                  const SizedBox(
                    width: 500,
                  ),
                  Visibility(
                    visible: _isShown,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(5),
                      child: SafeArea(
                        child: Container(
                          width: 380,
                          height: 230,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: 360,
                                        height: 50,
                                        child: _vehiclecount == true
                                            ? DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                    key: _key,
                                                    isExpanded: true,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusColor: Colors.black,
                                                      hoverColor: Colors.black,
                                                      labelText:
                                                          'Select Vehicle',
                                                      labelStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    elevation: 8,
                                                    iconSize: 30,
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Colors.black,
                                                    ),
                                                    items: data_vehicle_dropdown
                                                        .map((list) {
                                                      return DropdownMenuItem(
                                                        value: list.toString(),
                                                        child: Text(
                                                          list,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        var temp = value
                                                            .toString()
                                                            .split('-');

                                                        selected_vehicle =
                                                            temp[1].toString();
                                                      });
                                                    }),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                ),
                                                child: Center(
                                                  child: data_vehicle.isNotEmpty
                                                      ? Text(
                                                          '${model[0].toString().replaceAll(RegExp('[^A-Za-z]'), '')} - ${data_vehicle[0]}',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )
                                                      : Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            const Center(
                                                              child: Text(
                                                                // ignore: prefer_interpolation_to_compose_strings
                                                                'No Vehicle Added',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 160,
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pushNamed(
                                                                          myvehicleroute);
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                          ],
                                                        ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: const [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Select Services',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                    width: 10,
                                  ),
                                  Container(
                                    width: 360,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 290,
                                          height: 40,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Text(
                                                      service_Selected,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 80,
                                                // ),
                                                Visibility(
                                                  visible: _isshown3,
                                                  child: IconButton(
                                                      onPressed: (() {
                                                        setState(() {
                                                          service_Selected =
                                                              'No service selected';
                                                          _isshown3 = false;
                                                        });
                                                      }),
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                        size: 12,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              final String? results =
                                                  await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return MultiSelect(
                                                      items: data_service);
                                                },
                                              );

                                              if (results != null) {
                                                setState(() {
                                                  if (results == '') {
                                                    service_Selected =
                                                        'No service selected';
                                                    _isshown3 = false;
                                                  } else {
                                                    service_Selected = results;
                                                    _isshown3 = true;
                                                  }
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: 350,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_vehiclecount == false) {
                                      selected_vehicle = data_vehicle[0];
                                    }
                                    if (data_vehicle.isNotEmpty &&
                                        selected_vehicle.isNotEmpty) {
                                      if (service_Selected == '' ||
                                          service_Selected ==
                                              'No service selected') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: const Text(
                                            'Please select service',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          backgroundColor:
                                              Colors.orange.shade700,
                                        ));
                                      } else {
                                        hailingstatus = await Gethailingstatus()
                                            .getdata(
                                                {'service': 'GarageHailing'});
                                        if (hailingstatus == true) {
                                          List tempresult =
                                              await Checkrequestbyid()
                                                  .request(userid);

                                          if (tempresult.isEmpty) {
                                            var temp1 = '';

                                            temp1 = service_Selected;

                                            var tempdata =
                                                await fillterworkshoplist(
                                                    showLocation,
                                                    distanceradius,
                                                    selected_vehicle,
                                                    temp1);

                                            var temp = await tempdata
                                                .map<Workshopmodel>((json) =>
                                                    Workshopmodel.fromJson(
                                                        json))
                                                .toList();

                                            setState(() {
                                              datag = temp;
                                            });
                                            if (datag.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: const Text(
                                                  'No Workshop Nearby',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor:
                                                    Colors.orange.shade700,
                                              ));
                                            } else {
                                              setState(() {
                                                _isShown = !_isShown;
                                                _isshown3 = false;
                                              });
                                              List tempworkshopid = [];
                                              for (int i = 0;
                                                  i < datag.length;
                                                  i++) {
                                                tempworkshopid.add(
                                                    datag[i].id.toString());
                                              }

                                              String workshopidstring =
                                                  tempworkshopid.join(",");
                                              var data = {
                                                'registrationno':
                                                    selected_vehicle,
                                                'createddatetime':
                                                    DateTime.now().toString(),
                                                'status': 'SENT',
                                                'currentlatlong':
                                                    showLocation.toString(),
                                                'userid': userid,
                                                'servicename': temp1,
                                                'workshopidstring':
                                                    workshopidstring,
                                              };
                                              String status =
                                                  await CreateRequest()
                                                      .request(data);
                                              if (status == 'true') {
                                                setState(() {
                                                  _isShown2 = !_isShown2;
                                                });
                                                setState(() {
                                                  _isLoading1 = true;
                                                });
                                                mytimer = Timer.periodic(
                                                    const Duration(seconds: 2),
                                                    (timer) async {
                                                  checkstatus();
                                                });

                                                Future.delayed(
                                                    const Duration(seconds: 20),
                                                    () {
                                                  checkopenrequest();
                                                });
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                    'Error',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  backgroundColor:
                                                      Colors.orange.shade700,
                                                ));
                                                setState(() {
                                                  _isShown = !_isShown;
                                                });
                                              }
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: const Text(
                                                'Another Request In Process',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor:
                                                  Colors.orange.shade700,
                                            ));
                                          }
                                        } else {
                                          List tempdata =
                                              await fillterworkshoplist(
                                                  showLocation,
                                                  distanceradius,
                                                  selected_vehicle,
                                                  service_Selected);
                                          if (tempdata.isEmpty) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: const Text(
                                                'No Workshop Nearby',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              backgroundColor:
                                                  Colors.orange.shade700,
                                            ));
                                          } else {
                                            var temp = tempdata
                                                .map<Workshopmodel>((json) =>
                                                    Workshopmodel.fromJson(
                                                        json))
                                                .toList();

                                            setState(() {
                                              datag = temp;
                                            });

                                            Navigator.pushNamed(
                                                context, workshoproute,
                                                arguments: datag);
                                          }
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: const Text(
                                          'Please Add Vehicle',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Colors.orange.shade700,
                                      ));
                                    }
                                  },
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(5),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    )),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.orange.shade700),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.orange.shade200),
                                  ),
                                  child: const Text(
                                    'Connect To Garage',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    width: 500,
                  ),
                  Visibility(
                    visible: _isShown2,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        width: 380,
                        height: 230,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: !_isLoading1
                            ? Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text('Workshop Details',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        width: 80,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            service_Selected =
                                                'No service selected';
                                            _isShown = !_isShown;
                                            _isShown2 = !_isShown2;
                                            setState(() {
                                              markers = {};
                                              markers.add(Marker(
                                                markerId: const MarkerId('1'),
                                                position:
                                                    showLocation, //position of marker
                                                infoWindow: const InfoWindow(
                                                  title: 'Current Location ',
                                                ),
                                                icon:
                                                    markerbitmap, //Icon for Marker
                                              ));
                                            });
                                          });
                                        },
                                        child: const Text(
                                          "New Search",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text(
                                        'Name : ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            '${datagbyid[0].shop_name} | Distance - ${datagbyid[0].distance} KM',
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      const Text(
                                        'Address : ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Text(
                                            datagbyid[0].address_1.toString(),
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Clipboard.setData(ClipboardData(
                                                      text: datagbyid[0]
                                                          .phone_number
                                                          .toString()))
                                                  .then((value) {
                                                const snackBar = SnackBar(
                                                    content: Text(
                                                        'Phone Number Copied'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              });
                                            },
                                            style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(5),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green.shade100),
                                            ),
                                            child: const Text('Call')),
                                      ),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 100,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              MapUtils.openMap(
                                                  double.parse(
                                                      datagbyid[0].latitude ??
                                                          ''),
                                                  double.parse(
                                                      datagbyid[0].longitude ??
                                                          ''));
                                            },
                                            style: ButtonStyle(
                                              elevation:
                                                  MaterialStateProperty.all(5),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              )),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              overlayColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue.shade100),
                                            ),
                                            child: const Text('Direction')),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      color: Colors.orange.shade700),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Center(
                                      child: Text(
                                    'Searching for garage',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  )),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const SafeArea(
                                    child: Center(
                                      child: Image(
                                          image: AssetImage(
                                              'assets/images/icon.png')),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  checkopenrequest() async {
    List tempresult = await Checkrequestbyid().request(userid);
    if (tempresult.isNotEmpty) {
      if (tempresult[0]['status'] == 'OPEN' ||
          tempresult[0]['status'] == 'SENT') {
        var data = {
          'updateddatetime': DateTime.now().toString(),
          'status': 'CLOSED',
          'userid': userid
        };
        await CloseRequest().closerequest(data);
        setState(() {
          _isLoading1 = false;
        });
        mytimer.cancel();
        Navigator.pushNamed(context, workshoproute, arguments: datag);
      }
    }
  }

  checkstatus() async {
    List result = await Checkrequestbyid().request(userid);

    if (result.isNotEmpty) {
      if (result[0]['status'] == 'ACCEPTED') {
        var tempdata = await Getworkshopdatabyid()
            .getdata({'id': result[0]['workshopid']}, showLocation);
        datagbyid = tempdata
            .map<Workshopmodel>((json) => Workshopmodel.fromJson(json))
            .toList();
        setState(() {
          markers.add(Marker(
            markerId: MarkerId(datagbyid[0].shop_name.toString()),
            position: LatLng(
                double.parse(datagbyid[0].latitude.toString()),
                double.parse(
                    datagbyid[0].longitude.toString())), //position of marker
            infoWindow: const InfoWindow(
              title: 'Garage',
            ),
            icon: gargaebitmap_green, //Icon for Marker
          ));
        });

        var data = {
          'userid': userid,
          'workshopid': result[0]['workshopid'],
          'updateddatetime': DateTime.now().toString(),
          'status': 'ASSIGNED',
        };
        await UpdateRequestbyworkshopid().updaterequest(data);
        mytimer.cancel();
        setState(() {
          _isLoading1 = false;
        });
      }
    }
  }
}
