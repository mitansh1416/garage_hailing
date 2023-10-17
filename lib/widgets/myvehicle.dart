// ignore_for_file: camel_case_types

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garage_hailing/helper/Responsive.dart';
import 'package:garage_hailing/widgets/DESKTOP/adduservehciledesktop.dart';

import 'package:garage_hailing/widgets/MOBILE/adduservehiclemobile.dart';
import 'package:garage_hailing/widgets/TAB/adduservehicletab.dart';

class myvehicle extends StatelessWidget {
  const myvehicle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: Addvehicle(),
      tab: Addvehicletab(),
      desktop: Addvehicledesktop(),
    );
  }
}
