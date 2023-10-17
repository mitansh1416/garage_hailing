// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:garage_hailing/routes/routes.dart';

import 'package:garage_hailing/services/createuser.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import '../constant/userdetails.dart';
import '../services/getuserdata.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final firstNameEditingController = TextEditingController();
  final lastnameEditingController = TextEditingController();
  final emailController = TextEditingController();
  final phonenoEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameEditingController.dispose();
    lastnameEditingController.dispose();
    emailController.dispose();
    phonenoEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset('assets/images/spareit_logo.png'),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Text("SignUp",
                  style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: firstNameEditingController,
            decoration: InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: lastnameEditingController,
            decoration: InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 400,
            height: 50,
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Center(child: Text('+91')),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 280,
                  height: 50,
                  child: TextFormField(
                    controller: phonenoEditingController,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      phonenoEditingController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        labelText: "Phone No",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              emailController.text = value!;
            },
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 130,
                height: 10,
              ),
              ElevatedButton(
                onPressed: (() {
                  signup(
                      emailController.text,
                      firstNameEditingController.text,
                      lastnameEditingController.text,
                      phonenoEditingController.text);

                  _formKey.currentState?.reset();
                }),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  )),
                  minimumSize: MaterialStateProperty.all(const Size(30, 60)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.orange.shade700),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.white60),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const Text("Already Registered ? "),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(loginroute);
              },
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )
          ])
        ]),
      ),
    ));
  }

  Future<void> signup(
      String email, String firstname, String lastname1, String phoneno) async {
    var uuid = const Uuid();
    var data = {
      'userid': uuid.v1(),
      'firstname': firstname,
      'lastname': lastname1,
      'mobileno': phoneno,
      'email': email,
    };

    bool valid = validate(email, phoneno, firstname, lastname1);
    if (valid == true) {
      await CreateUser().createuser(data);
      var temp = await Getuserdata().getdata({'mobileno': phoneno});
      userid = temp[0]['userid'];
      name = temp[0]['firstname'];
      lastname = temp[0]['lastname'];
      mobileno = temp[0]['mobileno'];
      Email = temp[0]['email'];
      Navigator.of(context).pushNamed(addvehicleroute);
    }
  }

  bool validate(String email, String phone, String firstname, String lastname) {
    String patternEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regexEmail = RegExp(patternEmail);
    String pattternphone = r'(^(?:[+0]9)?[0-9]{10,10}$)';
    RegExp regExpPhone = RegExp(pattternphone);
    if (firstname.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid first name',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      firstNameEditingController.clear();
      return false;
    } else if (lastname.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid last name',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      lastnameEditingController.clear();
      return false;
    } else if (!regExpPhone.hasMatch(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid phone number',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      phonenoEditingController.clear();
      return false;
    } else if (!regexEmail.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter valid email',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange.shade700,
      ));
      emailController.clear();
      return false;
    }
    return true;
  }
}
