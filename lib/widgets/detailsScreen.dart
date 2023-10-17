// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:garage_hailing/helper/Responsive.dart';

import 'package:garage_hailing/widgets/DESKTOP/detailsscreendesktop.dart';

import 'package:garage_hailing/widgets/MOBILE/detailsscreenmobile.dart';

import 'package:garage_hailing/widgets/TAB/detailsscreentab.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var datag = ModalRoute.of(context)?.settings.arguments;

    return ResponsiveWidget(
        mobile: Detailsscreen(datag: datag),
        tab: Detailsscreentab(datag: datag),
        desktop: Detailsscreendesktop(datag: datag));
  }
}
