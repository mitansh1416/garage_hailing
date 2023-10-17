// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:garage_hailing/constant/services.dart';

import 'package:garage_hailing/routes/routes.dart';
import 'package:garage_hailing/services/gethailingservicestatus.dart';

import 'package:garage_hailing/services/locationpermission.dart';
import 'package:garage_hailing/widgets/404/error.dart';
import 'package:garage_hailing/widgets/GLOBAL%20WIDGET/addvehicle_signup.dart';
import 'package:garage_hailing/widgets/bookinghistory.dart';
import 'package:garage_hailing/widgets/detailsScreen.dart';

import 'package:garage_hailing/widgets/history.dart';
import 'package:garage_hailing/widgets/home.dart';

import 'package:garage_hailing/widgets/login.dart';
import 'package:garage_hailing/widgets/myvehicle.dart';
import 'package:garage_hailing/widgets/signup.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: loginroute,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const PageNotFound());
      },
      routes: {
        signuproute: (context) => const SignUp(),
        myvehicleroute: (context) => const myvehicle(),
        loginroute: (context) => const LoginScreen(),
        homeroute: (context) => const Home(),
        historyroute: (context) => const history(),
        workshoproute: (context) => const DetailsScreen(),
        addvehicleroute: (context) => const Addvehicle_signup(),
        bookinghistoryroute: (context) => const bookinghistory(),
      },
      title: "Garage Hailing",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        primaryColor: Colors.orange.shade700,
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        }),
      ),
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    Locationaccess().locationperimission();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreen(),
    );
  }
}
