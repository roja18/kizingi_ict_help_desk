import 'package:flutter/material.dart';
import 'package:kizingi_ict_help_deskv3/screens/login.dart';

import '../myRRequests.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('image/it.png'), fit: BoxFit.cover),
            ),
            child: null,
          ),
          // ListTile(
          //   leading: const Icon(Icons.message),
          //   title: const Text('Messages'),
          //   onTap: () {},
          // ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('My Requests'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyRequests()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
