// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/services/createuservehicle.dart';
import 'package:garage_hailing/services/deletevehicle.dart';
import 'package:garage_hailing/services/editvehicle.dart';
import 'package:garage_hailing/services/getvehicletype.dart';

import '../../constant/userdetails.dart';
import '../../routes/routes.dart';
import '../../services/getuservehicle.dart';

class Addvehicletab extends StatefulWidget {
  const Addvehicletab({Key? key}) : super(key: key);

  @override
  State<Addvehicletab> createState() => _AddvehicletabState();
}

class _AddvehicletabState extends State<Addvehicletab> {
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
      data_vehicle = temp;
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
                  IconButton(
                      onPressed: (() {
                        Navigator.of(context).pushNamed(homeroute);
                      }),
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(
                    height: 30,
                    width: 60,
                  ),
                  const Text(
                    'My Vehicle',
                    style: TextStyle(
                        fontSize: 22,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(child: Text('Add vehicle')),
                              content: StatefulBuilder(
                                  builder: ((context, setState) {
                                return SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: model,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Model");
                                            }
                                            // reg expression for email validation

                                            return null;
                                          },
                                          onSaved: (value) {
                                            model.text = value!;
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              labelText: "Model",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                                'Select Manufature Year'),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            IconButton(
                                                onPressed: (() {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Select Year"),
                                                        content: SizedBox(
                                                          // Need to use container to add size constraint.
                                                          width: 300,
                                                          height: 300,
                                                          child: YearPicker(
                                                            firstDate: DateTime(
                                                                DateTime.now()
                                                                        .year -
                                                                    100,
                                                                1),
                                                            lastDate: DateTime(
                                                                DateTime.now()
                                                                        .year +
                                                                    100,
                                                                1),
                                                            initialDate:
                                                                DateTime.now(),
                                                            selectedDate:
                                                                DateTime.now(),
                                                            onChanged: (DateTime
                                                                dateTime) {
                                                              setState(() {
                                                                _selecteddate =
                                                                    dateTime;
                                                              });
                                                              Navigator.pop(
                                                                  context,
                                                                  _selecteddate);
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }),
                                                icon: const Icon(
                                                    Icons.calendar_month)),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.black)),
                                            width: 150,
                                            height: 30,
                                            child: Align(
                                                alignment: Alignment.center,
                                                child: _selecteddate
                                                        .toString()
                                                        .isEmpty
                                                    ? Text(DateTime.now()
                                                        .year
                                                        .toString())
                                                    : Text(_selecteddate.year
                                                        .toString())),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                              key: _key,
                                              isExpanded: true,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                focusColor: Colors.black,
                                                hoverColor: Colors.black,
                                                labelText:
                                                    'Select Vehicle Type',
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selected_vehicle_type =
                                                      value.toString();
                                                });
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })),
                              actions: [
                                TextButton(
                                  onPressed: (() {
                                    Navigator.pop(context);
                                  }),
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: (() async {
                                    if (registrationno.text.isEmpty ||
                                        selected_vehicle_type.isEmpty ||
                                        brand.text.isEmpty ||
                                        model.text.isEmpty ||
                                        _selecteddate.toString().isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Fill all the details ");
                                    } else {
                                      var data = {
                                        'registrationno': registrationno.text,
                                        'vehicletypename':
                                            selected_vehicle_type,
                                        'brand': brand.text,
                                        'model': model.text,
                                        'manufactureyear':
                                            _selecteddate.year.toString(),
                                        'userid': userid
                                      };
                                      bool temp = await CreateUserVehicle()
                                          .createuser(data);
                                      if (temp == true) {
                                        registrationno.clear();

                                        brand.clear();

                                        model.clear();
                                        Navigator.of(context)
                                            .pushNamed(myvehicleroute);
                                      }
                                    }
                                  }),
                                  child: const Text('Submit'),
                                ),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "Add Vehicle",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  )
                ],
              ),
              Expanded(
                child: data_vehicle.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: data_vehicle.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              hoverColor: Colors.grey,
                              title: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Registration No - ${data_vehicle[index]['registrationno']}',
                                        style: const TextStyle(
                                            fontSize: 15,
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
                                      Text(
                                        'Brand - ${data_vehicle[index]['brand']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 110,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            final TextEditingController
                                                registrationno_edit =
                                                TextEditingController(
                                                    text: data_vehicle[index]
                                                        ['registrationno']);
                                            final TextEditingController
                                                brand_edit =
                                                TextEditingController(
                                                    text: data_vehicle[index]
                                                        ['brand']);
                                            final TextEditingController
                                                model_edit =
                                                TextEditingController(
                                                    text: data_vehicle[index]
                                                        ['model']);
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Center(
                                                        child: Text(
                                                            'Edit vehicle')),
                                                    content: StatefulBuilder(
                                                        builder: ((context,
                                                            setState) {
                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  registrationno_edit,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Please Enter Registration No");
                                                                }

                                                                return null;
                                                              },
                                                              onSaved: (value) {
                                                                registrationno_edit
                                                                        .text =
                                                                    value!;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                      "Registrtion No",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  brand_edit,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Please Enter Brand");
                                                                }

                                                                return null;
                                                              },
                                                              onSaved: (value) {
                                                                brand_edit
                                                                        .text =
                                                                    value!;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                      "Brand",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  model_edit,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return ("Please Enter Model");
                                                                }

                                                                return null;
                                                              },
                                                              onSaved: (value) {
                                                                model_edit
                                                                        .text =
                                                                    value!;
                                                              },
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: InputDecoration(
                                                                  labelText:
                                                                      "Model",
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20))),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                    'Select Manufature Year'),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        (() {
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                            title:
                                                                                const Text("Select Year"),
                                                                            content:
                                                                                SizedBox(
                                                                              // Need to use container to add size constraint.
                                                                              width: 300,
                                                                              height: 300,
                                                                              child: YearPicker(
                                                                                firstDate: DateTime(DateTime.now().year - 100, 1),
                                                                                lastDate: DateTime(DateTime.now().year + 100, 1),
                                                                                initialDate: DateTime.now(),
                                                                                selectedDate: DateTime.now(),
                                                                                onChanged: (DateTime dateTime) {
                                                                                  setState(() {
                                                                                    _selecteddate = dateTime;
                                                                                  });
                                                                                  Navigator.pop(context, _selecteddate);
                                                                                },
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );
                                                                    }),
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .calendar_month)),
                                                              ],
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
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
                                                                    child: _selecteddate
                                                                            .toString()
                                                                            .isEmpty
                                                                        ? Text(DateTime.now()
                                                                            .year
                                                                            .toString())
                                                                        : Text(_selecteddate
                                                                            .year
                                                                            .toString())),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButtonFormField(
                                                                      key: _key,
                                                                      value: data_vehicle[
                                                                              index][
                                                                          'vehicletypename'],
                                                                      isExpanded:
                                                                          true,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border: OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20)),
                                                                        focusColor:
                                                                            Colors.black,
                                                                        hoverColor:
                                                                            Colors.black,
                                                                        labelText:
                                                                            'Select Vehicle Type',
                                                                        labelStyle:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                      elevation:
                                                                          8,
                                                                      iconSize:
                                                                          18,
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .arrow_drop_down,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                      items: vehicle_type
                                                                          .map(
                                                                              (list) {
                                                                        return DropdownMenuItem(
                                                                          value:
                                                                              list.toString(),
                                                                          child:
                                                                              Text(
                                                                            list,
                                                                            style:
                                                                                const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          selected_vehicle_type =
                                                                              value.toString();
                                                                        });
                                                                      }),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    })),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: (() {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                        child: const Text(
                                                            'Cancel'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: (() async {
                                                          if (selected_vehicle_type
                                                              .isEmpty) {
                                                            selected_vehicle_type =
                                                                data_vehicle[
                                                                        index][
                                                                    'vehicletypename'];
                                                          }

                                                          var data = {
                                                            'registrationno':
                                                                data_vehicle[
                                                                        index][
                                                                    'registrationno'],
                                                            'vehicletypename':
                                                                selected_vehicle_type,
                                                            'brand':
                                                                brand_edit.text,
                                                            'model':
                                                                model_edit.text,
                                                            'manufactureyear':
                                                                _selecteddate
                                                                    .year
                                                                    .toString(),
                                                            'userid': userid,
                                                            'editregistration':
                                                                registrationno_edit
                                                                    .text,
                                                          };
                                                          var temp =
                                                              await Editvehicle()
                                                                  .edit(data);

                                                          if (temp == true) {
                                                            registrationno_edit
                                                                .clear();

                                                            brand_edit.clear();

                                                            model_edit.clear();

                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                                    myvehicleroute);
                                                          } else {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content:
                                                                  const Text(
                                                                'Error Occured',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              backgroundColor:
                                                                  Colors.orange
                                                                      .shade700,
                                                            ));
                                                          }
                                                        }),
                                                        child: const Text(
                                                            'Submit'),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            var temp = await Deletevehicle()
                                                .delete({
                                              'userid': userid,
                                              'registrationno':
                                                  data_vehicle[index]
                                                      ['registrationno']
                                            });
                                            if (temp == true) {
                                              Navigator.of(context)
                                                  .pushNamed(myvehicleroute);
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Model - ${data_vehicle[index]['model']}',
                                        style: const TextStyle(
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
                                      Text(
                                        'Manufacture Year - ${data_vehicle[index]['manufactureyear']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text(
                          'No Vehicle',
                          style: TextStyle(
                              fontSize: 18,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
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
