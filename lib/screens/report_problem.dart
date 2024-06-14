import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/my_drawer.dart';
import 'component/reusable_widget.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  final TextEditingController _problemController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String selectedPriority = '';
  User? userCredential;

  @override
  void initState() {
    super.initState();
    userCredential = FirebaseAuth.instance.currentUser;
  }

  Future<void> _requestSupport() async {
    // Check if the user is authenticated
    if (userCredential == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not authenticated. Please sign in.')),
      );
      return;
    }

    // Gather all the data
    String title = _problemController.text;
    String description = _descriptionController.text;

    // Create a map of the data
    Map<String, dynamic> requestData = {
      'title': title,
      'description': description,
      'priority': selectedPriority,
      'userId': userCredential!.uid,
      'status': 'processing',
    };

    // Send the data to Firestore
    await FirebaseFirestore.instance.collection('problems').add(requestData);

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Problem report submitted successfully')),
    );

    // Clear the form
    _problemController.clear();
    _descriptionController.clear();
    setState(() {
      selectedPriority = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'ICT Help Problems',
            style: TextStyle(color: Colors.lightBlue),
          ),
          elevation: 0,
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: 180,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('image/desk.png'),
                  fit: BoxFit.cover, // Set fit to cover the entire container
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0, 4),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: null, // You can remove the child if not needed
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Report a Problem',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableTextFild(
                      "Enter Problem", Icons.title, false, _problemController),
                  const SizedBox(height: 15),
                  ReusableTextareaFild(
                    controller: _descriptionController,
                    hintText: 'Type here Description of the problem...',
                    icon: Icons.edit,
                    isPasswordType: false,
                  ),
                  const SizedBox(height: 15),
                  ReusableDropdownField(
                    hintText: 'Select Priority',
                    icon: Icons.priority_high,
                    items: ['Low', 'Medium', 'High', 'Critical'],
                    selectedItem: selectedPriority,
                    onChanged: (value) {
                      setState(() {
                        selectedPriority = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  mybutton(context, "Report Problem", () {
                    _requestSupport();
                  }),
                ],
              ),
            ),
          ),
        ])));
  }
}
