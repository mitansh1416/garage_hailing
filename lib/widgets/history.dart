// ignore_for_file: camel_case_types

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garage_hailing/helper/Responsive.dart';
import 'package:garage_hailing/widgets/DESKTOP/historydesktop.dart';

import 'package:garage_hailing/widgets/MOBILE/historymobile.dart';

import 'package:garage_hailing/widgets/TAB/historytab.dart';

class history extends StatelessWidget {
  const history({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: History(),
      tab: HistoryTab(),
      desktop: HistoryDesktop(),
    );
  }
}
