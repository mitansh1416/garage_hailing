// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/constant/userdetails.dart';
import 'package:garage_hailing/routes/routes.dart';
import 'package:garage_hailing/services/getuserdata.dart';

import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // editing controller
  final TextEditingController phoneController = TextEditingController();

  List temp = [];

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/spareit_logo.png'),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              Text("Login",
                  style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 25,
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
                  width: 270,
                  height: 50,
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    onSaved: (value) {
                      phoneController.text = value!;
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
            height: 15,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 130,
                height: 15,
              ),
              ElevatedButton(
                onPressed: (() {
                  signIn(phoneController.text);
                  phoneController.clear();
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
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            const Text("Don't have an account? "),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(signuproute);
              },
              child: const Text(
                "SignUp",
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

  void signIn(String phone) async {
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Please enter phone number',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange.shade700,
      ));
    } else {
      String patttern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
      RegExp regExp = RegExp(patttern);
      if (!regExp.hasMatch(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Please enter a valid phone number',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.orange.shade700,
        ));
      } else {
        temp = await Getuserdata().getdata({'mobileno': phone});
        if (temp.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text(
              'No Account With This Phone No - Please Sign Up',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange.shade700,
          ));
        } else {
          userid = temp[0]['userid'];
          name = temp[0]['firstname'];
          lastname = temp[0]['lastname'];
          mobileno = temp[0]['mobileno'];
          Email = temp[0]['email'];
          Navigator.of(context).pushNamed(homeroute);
          Fluttertoast.showToast(msg: "Login Successful");
        }
      }
    }
  }
}
