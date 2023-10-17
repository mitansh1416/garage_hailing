import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garage_hailing/helper/Responsive.dart';
import 'package:garage_hailing/widgets/DESKTOP/homedesktop.dart';
import 'package:garage_hailing/widgets/MOBILE/homemobile.dart';
import 'package:garage_hailing/widgets/TAB/hometab.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: HomeMobile(), tab: HomeTab(), desktop: HomeDesktop());
  }
}
