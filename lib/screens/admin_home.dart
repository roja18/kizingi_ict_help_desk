import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'list_of_issues_admin.dart';
import 'login.dart';
import 'technician.dart';
import 'technician_list.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.lightBlue),
          child: const Padding(
            padding: EdgeInsets.only(top: 100.0, left: 22.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ICT Help Desk",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Admin Pannel",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              ),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 5.0, right: 5.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ListIssuesPage()));
                                  },
                                  child: Card(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        height: 200,
                                        // width: MediaQuery.of(context).size.width,
                                        width: 150,
                                        child:
                                            Image.asset('image/request.webp')),
                                  ),
                                ),
                                const Column(
                                  children: [
                                    Text(
                                      'Users Requests',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue),
                                    ),
                                    Text(
                                      'Assistance',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.lightBlue),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              children: [
                                Card(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      height: 200,
                                      width: 150,
                                      child: Image.asset('image/smss.png')),
                                ),
                                const Text(
                                  'Chart Assistance',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ListOfTechnician()));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      height: 200,
                                      width: 150,
                                      child: Image.asset('image/ctech.png'),
                                    ),
                                  ),
                                  const Text(
                                    'Technicians',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                                width: 16), // Adding space between the columns
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Log Out"),
                                      content: const Text(
                                          "Are you sure you want to log out?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            FirebaseAuth.instance
                                                .signOut()
                                                .then((value) {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                                (Route<dynamic> route) => false,
                                              );
                                            });
                                          },
                                          child: const Text("Log Out"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      height: 200,
                                      width: 150,
                                      child: Image.asset('image/signout.png'),
                                    ),
                                  ),
                                  const Text(
                                    'Log Out',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
