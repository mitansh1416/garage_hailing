import 'package:flutter/material.dart';

import 'package:garage_hailing/constant/userdetails.dart';
import 'package:garage_hailing/routes/routes.dart';
import 'package:garage_hailing/services/getgaragebyid.dart';

import 'package:garage_hailing/services/getuserrequestdatahistory.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  List history = [];
  List workshopbyid = [];
  List finallist = [];
  LatLng location = const LatLng(0, 0);
  Future gethistory() async {
    List temp = await Gethistory().getdata({'userid': userid});

    for (int i = 0; i < temp.length; i++) {
      history.add(temp[i]);
    }
    for (int j = 0; j < history.length; j++) {
      if (history[j]['status'] == 'ASSIGNED') {
        var temp2 = await Getworkshopdatabyid()
            .getdata({'id': history[j]['workshopid']}, location);

        history[j]['workshop'] = temp2[0]['shop_name'];
      } else {
        history[j]['workshop'] = 'No workshop assigned';
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
                      'Workshop Requests',
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
                                  height: 120,
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
                                            'Request Id - ',
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
                                            finallist[index]['transactionid']
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
                                            finallist[index]['workshop']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                decoration: TextDecoration.none,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Center(
                            child: Text(
                              'No History',
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
