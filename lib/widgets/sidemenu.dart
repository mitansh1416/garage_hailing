import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:garage_hailing/constant/userdetails.dart';
import 'package:garage_hailing/routes/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.orange,
          ),
          child: Center(
            child: Row(
              children: [
                const Expanded(
                  flex: 2,
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text("Home"),
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
          ),
          onTap: () {
            Navigator.of(context).pushNamed(homeroute);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: const Text("My Vehicle"),
          leading: IconButton(
            icon: const Icon(Icons.bike_scooter_rounded),
            onPressed: () {},
          ),
          onTap: () {
            Navigator.of(context).pushNamed(myvehicleroute);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: const Text("Workshop Requests"),
          leading: IconButton(
            icon: const Icon(Icons.watch_later_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(historyroute);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: const Text("Bookings"),
          leading: IconButton(
            icon: const Icon(Icons.watch_later_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          onTap: () {
            Navigator.of(context).pushNamed(bookinghistoryroute);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        ListTile(
          title: const Text('Log Out'),
          leading: IconButton(
            icon: const Icon(Icons.logout_sharp),
            onPressed: () {
              logout(context);
            },
          ),
          onTap: () {
            logout(context);
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(
          height: 220,
        ),
      ],
    );
  }

  Future<void> logout(BuildContext context) async {
    Navigator.of(context).popUntil(ModalRoute.withName(loginroute));
    Fluttertoast.showToast(msg: "Logout Successful");
  }
}
