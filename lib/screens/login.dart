import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin_home.dart';
import 'component/reusable_widget.dart';
import 'home.dart';
import 'regster.dart';
import 'technician_panel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
            child: Text(
              "ICT Help Desk",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold),
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
              padding: EdgeInsets.only(top: 40, left: 28.0, right: 28.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    reusableTextFild("Enter Email Address", Icons.mail, false,
                        _emailController),
                    const SizedBox(height: 15),
                    reusableTextFild("Enter Password", Icons.lock, true,
                        _passwordController),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forget Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(228, 3, 131, 236)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    signInSignoutbutton(context, true, () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Center(child: CircularProgressIndicator());
                        },
                      );
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) async {
                        // Fetch the user type from Firestore
                        User? user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          DocumentSnapshot userDoc = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(user.uid)
                              .get();
                          String userType = userDoc['usertype'];

                          Navigator.pop(context); // Close the progress dialog

                          // Navigate to the appropriate page based on user type
                          if (userType == 'User') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else if (userType == 'Admin') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminHome()));
                          } else if (userType == 'Technician') {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TechnicianHome()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Unknown user type'),
                              ),
                            );
                          }
                        }
                      }).onError((error, stackTrace) {
                        Navigator.pop(context); // Close the progress dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              padding: const EdgeInsets.all(16),
                              height: 90,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 219, 30, 17),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Error",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text("Error ${error.toString()}"),
                                  ]),
                            ),
                          ),
                        );
                      });
                    }),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I don\'t have an Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(228, 3, 131, 236)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegsterPage()));
                            },
                            child: Text(
                              ' Regster',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(227, 0, 140, 255)),
                            ),
                          ),
                        ],
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
