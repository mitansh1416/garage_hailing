// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/routes/routes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constant/userdetails.dart';
import '../../services/getbookinghistory.dart';
import '../../services/getgaragebyid.dart';
import '../../services/updatebooking.dart';

class Bookinghistorytab extends StatefulWidget {
  const Bookinghistorytab({super.key});

  @override
  State<Bookinghistorytab> createState() => _BookinghistorytabState();
}

class _BookinghistorytabState extends State<Bookinghistorytab> {
  List history = [];
  List workshopbyid = [];
  List finallist = [];
  LatLng location = const LatLng(0, 0);
  Future gethistory() async {
    List temp = await GetBookinghistory().getdata({'userid': userid});
    for (int i = 0; i < temp.length; i++) {
      history.add(temp[i]);
    }
    for (int j = 0; j < history.length; j++) {
      var temp2 = await Getworkshopdatabyid()
          .getdata({'id': history[j]['workshopid']}, location);
      history[j]['workshopname'] = temp2[0]['shop_name'];
      history[j]['phonenumber'] = temp2[0]['phone_number'];
      if (history[j]['status'] == 'RECIVED') {
        history[j]['status'] = 'On Going';
      } else {
        history[j]['status'] = 'Cancelled';
      }
    }

    setState(() {
      finallist = history;
    });
  }

  @override
  void initState() {
    super.initState();

    gethistory();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 5,
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
                    IconButton(
                        onPressed: (() {
                          Navigator.of(context).pushNamed(homeroute);
                        }),
                        icon: const Icon(Icons.arrow_back)),
                    const SizedBox(
                      height: 30,
                      width: 100,
                    ),
                    const Text(
                      'Bookings',
                      style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
                Expanded(
                    child: finallist.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: finallist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.all(10),
                                child: Container(
                                  width: 380,
                                  height: 240,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Registration No - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['registrationno']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 150,
                                          ),
                                          finallist[index]['status'] ==
                                                  'Cancelled'
                                              ? const SizedBox()
                                              : TextButton(
                                                  onPressed: (() async {
                                                    var status =
                                                        await updatebookingstatus()
                                                            .update({
                                                      'bookingid':
                                                          finallist[index]
                                                              ['bookingid'],
                                                      'status': 'CANCELLED',
                                                      'updateddatetime':
                                                          DateTime.now()
                                                              .toString()
                                                    });
                                                    if (status == true) {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Booking Cancelled');
                                                      Navigator.of(context)
                                                          .pushNamed(
                                                              bookinghistoryroute);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Cannot cancel booking at this moment');
                                                    }
                                                  }),
                                                  child: const Text('Cancel'))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Service Name - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['servicename']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Booking Date - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['date_booking']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Booking Time - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['time_booking']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Comments - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['comments']
                                                    .toString()
                                                    .isEmpty
                                                ? 'No Comments'
                                                : finallist[index]['comments']
                                                    .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Workshop - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['workshopname']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Workshop Phone No - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          TextButton(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                        ClipboardData(
                                                            text: finallist[
                                                                        index][
                                                                    'phonenumber']
                                                                .toString()))
                                                    .then((value) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Phone Number Copied');
                                                });
                                              },
                                              child: Text(
                                                finallist[index]['phonenumber']
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    decoration:
                                                        TextDecoration.none,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.black),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          const Text(
                                            'Status - ',
                                            style: TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            finallist[index]['status']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text(
                              'No Bookings',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black),
                            ),
                          )),
              ],
            ),
          ),
        ));
  }
}
