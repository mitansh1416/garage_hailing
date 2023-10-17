// ignore_for_file: camel_case_types, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/routes/routes.dart';

import '../../constant/userdetails.dart';
import '../../services/createuservehicle.dart';
import '../../services/getuservehicle.dart';
import '../../services/getvehicletype.dart';

class Addvehicle_signup extends StatefulWidget {
  const Addvehicle_signup({Key? key}) : super(key: key);

  @override
  State<Addvehicle_signup> createState() => _Addvehicle_signupState();
}

class _Addvehicle_signupState extends State<Addvehicle_signup> {
  final TextEditingController registrationno = TextEditingController();
  final TextEditingController brand = TextEditingController();
  final TextEditingController model = TextEditingController();
  DateTime _selecteddate = DateTime.now();
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  String selected_vehicle_type = '';
  List data_vehicle = [];
  List vehicle_type = [];
  Future getvehiclenameandtype() async {
    List temp = await Getuservehicledata().getdata(userid);
    List temp1 = await Getvehicletype().getdata();

    setState(() {
      for (int i = 0; i < temp.length; i++) {
        data_vehicle.add(temp[i]);
      }
      for (int j = 0; j < temp1.length; j++) {
        vehicle_type.add(temp1[j]['name']);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getvehiclenameandtype();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              child: SingleChildScrollView(
                child: Container(
                  width: 380,
                  height: 550,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 120,
                          ),
                          const Center(
                            child: Text(
                              'Add Vehicle',
                              style: TextStyle(
                                  fontSize: 22,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          InkWell(
                            onTap: (() {
                              Navigator.of(context).pushNamed(homeroute);
                            }),
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: registrationno,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Registration No");
                            }
                            // reg expression for email validation

                            return null;
                          },
                          onSaved: (value) {
                            registrationno.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Registrtion No",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: brand,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Brand");
                            }
                            // reg expression for email validation

                            return null;
                          },
                          onSaved: (value) {
                            brand.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Brand",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: model,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Model");
                            }

                            return null;
                          },
                          onSaved: (value) {
                            model.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              labelText: "Model",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 50,
                          ),
                          const Text('Select Manufature Year',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: (() {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Select Year"),
                                      content: SizedBox(
                                        // Need to use container to add size constraint.
                                        width: 300,
                                        height: 300,
                                        child: YearPicker(
                                          firstDate: DateTime(
                                              DateTime.now().year - 100, 1),
                                          lastDate: DateTime(
                                              DateTime.now().year + 100, 1),
                                          initialDate: DateTime.now(),
                                          selectedDate: _selecteddate,
                                          onChanged: (DateTime dateTime) {
                                            setState(() {
                                              _selecteddate = dateTime;
                                            });
                                            Navigator.pop(
                                                context, _selecteddate);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          width: 150,
                          height: 30,
                          child: Align(
                              alignment: Alignment.center,
                              child: _selecteddate.toString().isEmpty
                                  ? Text(DateTime.now().year.toString())
                                  : Text(_selecteddate.year.toString())),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              key: _key,
                              isExpanded: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusColor: Colors.black,
                                hoverColor: Colors.black,
                                labelText: 'Select Vehicle Type',
                                labelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              elevation: 8,
                              iconSize: 18,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                              items: vehicle_type.map((list) {
                                return DropdownMenuItem(
                                  value: list.toString(),
                                  child: Text(
                                    list,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selected_vehicle_type = value.toString();
                                });
                              }),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: (() async {
                            addvehicle(
                                registrationno.text,
                                selected_vehicle_type.toString(),
                                brand.text,
                                model.text,
                                _selecteddate.year.toString());
                          }),
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            )),
                            minimumSize:
                                MaterialStateProperty.all(const Size(30, 60)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.orange.shade700),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            overlayColor:
                                MaterialStateProperty.all(Colors.white60),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addvehicle(regno, typename, brands, models, manufactureyear) async {
    bool valid = validate(regno, typename, brands, models, manufactureyear);
    if (valid == true) {
      var data = {
        'registrationno': regno,
        'vehicletypename': typename,
        'brand': brands,
        'model': models,
        'manufactureyear': manufactureyear,
        'userid': userid
      };
      bool temp = await CreateUserVehicle().createuser(data);

      if (temp == true) {
        Fluttertoast.showToast(msg: "Vehicle Added Successful");
        Navigator.of(context).pushNamed(homeroute);
      }
    }
  }

  bool validate(String regno, String typename, String brands, String models,
      String manufactureyear) {
    // String regnopattern = r'^[A-Z]{2}\s[0-9]{1,2}\s[A-Z]{1,2}\s[0-9]{1,4}$';
    // RegExp regnoregex = RegExp(regnopattern);

    if (regno.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid registration no',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      registrationno.clear();
      return false;
    } else if (brands.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid brand name',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      brand.clear();
      return false;
    } else if (models.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid model name',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      model.clear();
      return false;
    } else if (manufactureyear.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please select manufacture year',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));

      return false;
    } else if (typename.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please select vehicle type',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));

      return false;
    }

    return true;
  }
}
