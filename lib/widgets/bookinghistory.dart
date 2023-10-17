// ignore_for_file: camel_case_types

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garage_hailing/helper/Responsive.dart';
import 'package:garage_hailing/widgets/DESKTOP/bookinghistorydekstop.dart';
import 'package:garage_hailing/widgets/MOBILE/bookinghistorymobile.dart';
import 'package:garage_hailing/widgets/TAB/bookinghistorytab.dart';

class bookinghistory extends StatelessWidget {
  const bookinghistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobile: Bookinghisotrymobile(),
      tab: Bookinghistorytab(),
      desktop: BookinghisotryDesktop(),
    );
  }
}
