// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/constant/userdetails.dart';

import 'package:garage_hailing/routes/routes.dart';
import 'package:garage_hailing/services/bookingrequest.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../services/googlemapsdirection.dart';

// ignore: must_be_immutable
class Detailsscreen extends StatefulWidget {
  var datag;
  Detailsscreen({Key? key, required this.datag}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<Detailsscreen> createState() => _DetailsscreenState(datag);
}

class _DetailsscreenState extends State<Detailsscreen> {
  var datag;
  final TextEditingController comments_controller = TextEditingController();
  var newStartDate = '';

  var pickedTime = '';
  final now = DateTime.now();
  _DetailsscreenState(this.datag);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var currentDate = DateFormat('yyyy/MM/dd').format(now).toString();
    var initialTime = TimeOfDay.now().format(context).toString();
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width - 30,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 30,
                    width: 10,
                  ),
                  const Text(
                    'Workshop(s) near you',
                    style: TextStyle(
                        fontSize: 22,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 150,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(homeroute);
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
              Expanded(
                child: datag.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: datag.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              hoverColor: Colors.grey,
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Distance - ${datag[index].distance} KM   |',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        datag[index].shop_name.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        datag[index].address_1.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                                text:
                                                    datag[index].phone_number))
                                            .then((value) {
                                          Fluttertoast.showToast(
                                              msg: 'Phone Number Copied');
                                        });
                                      },
                                      icon: Icon(
                                        Icons.call,
                                        color: Colors.green[700],
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        MapUtils.openMap(
                                            double.parse(
                                                datag[index].latitude ?? ''),
                                            double.parse(
                                                datag[index].longitude ?? ''));
                                      },
                                      icon: const Icon(
                                        Icons.directions,
                                        color: Colors.blue,
                                      )),
                                  InkWell(
                                    onTap: (() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Center(
                                                  child:
                                                      Text('Book Appointment')),
                                              content: StatefulBuilder(
                                                builder: ((context, setState) {
                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            datag[index]
                                                                .registrationno
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            datag[index]
                                                                .shop_name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          child: Center(
                                                              child: Text(
                                                            datag[index]
                                                                .service
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          )),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              comments_controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          onSaved: (value) {
                                                            comments_controller
                                                                .text = value!;
                                                          },
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          maxLines: 6,
                                                          minLines: 3,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .top,
                                                          decoration: InputDecoration(
                                                              labelText:
                                                                  "Comments",
                                                              hintText:
                                                                  'Describe Issues',
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5))),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Select Date',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black)),
                                                              width: 150,
                                                              height: 30,
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: newStartDate
                                                                          .isEmpty
                                                                      ? Text(
                                                                          currentDate)
                                                                      : Text(
                                                                          newStartDate)),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            IconButton(
                                                              onPressed: (() {
                                                                // date selecting logic
                                                                showDatePicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            DateTime
                                                                                .now(),
                                                                        firstDate:
                                                                            DateTime
                                                                                .now(),
                                                                        lastDate:
                                                                            DateTime(
                                                                                2300))
                                                                    .then(
                                                                        (date) {
                                                                  setState(() {
                                                                    newStartDate = DateFormat(
                                                                            'yyyy/MM/dd')
                                                                        .format(
                                                                            date!)
                                                                        .toString();
                                                                  });
                                                                });
                                                              }),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .date_range),
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            'Select Time',
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .black)),
                                                              width: 150,
                                                              height: 30,
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: pickedTime
                                                                          .isEmpty
                                                                      ? Text(initialTime
                                                                          .toString())
                                                                      : Text(pickedTime
                                                                          .toString())),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            IconButton(
                                                                onPressed:
                                                                    (() async {
                                                                  showTimePicker(
                                                                          context:
                                                                              context,
                                                                          initialTime: TimeOfDay
                                                                              .now())
                                                                      .then(
                                                                          (value) {
                                                                    setState(
                                                                        () {
                                                                      var temp =
                                                                          value?.format(
                                                                              context);
                                                                      pickedTime =
                                                                          temp.toString();
                                                                    });
                                                                  });
                                                                }),
                                                                icon: const Icon(
                                                                    Icons
                                                                        .watch_later_outlined))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: (() {
                                                    comments_controller.clear();

                                                    newStartDate = '';
                                                    pickedTime = '';
                                                    Navigator.pop(context);
                                                  }),
                                                  child: const Text('Cancel'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: (() async {
                                                    var uuid = const Uuid();
                                                    var data = {
                                                      'bookingid': uuid.v1(),
                                                      'userid': userid,
                                                      'registrationno':
                                                          datag[index]
                                                              .registrationno
                                                              .toString(),
                                                      'workshopid': datag[index]
                                                          .id
                                                          .toString(),
                                                      'servicename':
                                                          datag[index]
                                                              .service
                                                              .toString(),
                                                      'comments':
                                                          comments_controller
                                                              .text
                                                              .toString(),
                                                      'date_booking':
                                                          newStartDate.isEmpty
                                                              ? currentDate
                                                              : newStartDate,
                                                      'time_booking':
                                                          pickedTime.isEmpty
                                                              ? initialTime
                                                                  .toString()
                                                              : pickedTime
                                                                  .toString(),
                                                      'createddatetime':
                                                          DateTime.now()
                                                              .toString()
                                                    };
                                                    var status =
                                                        await CreateBookingRequest()
                                                            .request(data);
                                                    if (status == true) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title:
                                                                  const Center(
                                                                child: Text(
                                                                    'Booking Done'),
                                                              ),
                                                              content: Builder(
                                                                builder:
                                                                    (context) {
                                                                  var height =
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height;
                                                                  var width =
                                                                      MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width;
                                                                  return SizedBox(
                                                                    height:
                                                                        height -
                                                                            580,
                                                                    width:
                                                                        width -
                                                                            100,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              'Please contact ${datag[index].shop_name} , Contact No :',
                                                                              style: const TextStyle(fontSize: 14),
                                                                            ),
                                                                            TextButton(
                                                                                onPressed: (() async {
                                                                                  await Clipboard.setData(ClipboardData(text: datag[index].phone_number)).then((value) {
                                                                                    Fluttertoast.showToast(msg: 'Phone Number Copied');
                                                                                  });
                                                                                }),
                                                                                child: Text(datag[index].phone_number.toString())),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: const [
                                                                            Text(' To confirm on services required & booking schedule',
                                                                                style: TextStyle(fontSize: 14)),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        (() async {
                                                                      Navigator.pop(
                                                                          context);
                                                                      Navigator.pop(
                                                                          context);
                                                                    }),
                                                                    child:
                                                                        const Text(
                                                                            'OK'))
                                                              ],
                                                            );
                                                          });
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Booking not available at the moment');
                                                      Navigator.pop(context);
                                                    }
                                                  }),
                                                  child: const Text('Book'),
                                                )
                                              ],
                                            );
                                          });
                                    }),
                                    child: Text(
                                      "Book",
                                      style: TextStyle(
                                          color: Colors.orange.shade700,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No Workshop Near By',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
