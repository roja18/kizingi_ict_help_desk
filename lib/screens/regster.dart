import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/reusable_widget.dart';
import 'login.dart';

class RegsterPage extends StatefulWidget {
  const RegsterPage({super.key});

  @override
  State<RegsterPage> createState() => _RegsterPageState();
}

class _RegsterPageState extends State<RegsterPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _fullnameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Create user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Send additional user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullname': _fullnameController.text,
        'registration': _phoneController.text,
        'email': _emailController.text.trim(),
        'usertype': 'User',
      });

      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
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
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Error",
                  style: TextStyle(fontSize: 18),
                ),
                Text("Error: ${error.message}"),
              ],
            ),
          ),
        ),
      );
    } catch (error) {
      Navigator.of(context).pop();
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
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Error",
                  style: TextStyle(fontSize: 18),
                ),
                Text("Error: ${error.toString()}"),
              ],
            ),
          ),
        ),
      );
      print("Error: ${error.toString()}");
    }
  }

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
                  color: Colors.white,
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
                    reusableTextFild("Enter FullName", Icons.person, false,
                        _fullnameController),
                    const SizedBox(height: 15),
                    reusableTextFild(
                      "Enter Phone Number",
                      Icons.numbers,
                      false,
                      _phoneController,
                    ),
                    const SizedBox(height: 15),
                    reusableTextFild("Enter Email Address", Icons.mail, false,
                        _emailController),
                    const SizedBox(height: 15),
                    reusableTextFild("Enter Password", Icons.lock, true,
                        _passwordController),
                    const SizedBox(height: 30),
                    signInSignoutbutton(context, false, () {
                      signUp();
                    }),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'I have an Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(228, 3, 131, 236)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text(
                              ' LOGIN',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(228, 3, 131, 236)),
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
