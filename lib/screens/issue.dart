import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/my_drawer.dart';
import 'component/reusable_widget.dart';

class IssuesPage extends StatefulWidget {
  const IssuesPage({super.key});

  @override
  State<IssuesPage> createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _officeController = TextEditingController();
  String selectedCategory = '';
  String selectedPriority = '';
  String selectedDeviceType = '';
  String selectedOS = '';
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
    String title = _titleController.text;
    String description = _descriptionController.text;
    String office = _officeController.text;

    // Create a map of the data
    Map<String, dynamic> requestData = {
      'title': title,
      'description': description,
      'office': office,
      'category': selectedCategory,
      'priority': selectedPriority,
      'deviceType': selectedDeviceType,
      'operatingSystem': selectedOS,
      'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      'userId': userCredential!.uid,
      'status': 'processing',
    };

    // Send the data to Firestore
    await FirebaseFirestore.instance.collection('requests').add(requestData);

    // Optionally, show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Support request submitted successfully')),
    );

    // Clear the form
    _titleController.clear();
    _descriptionController.clear();
    _officeController.clear();
    setState(() {
      selectedCategory = '';
      selectedPriority = '';
      selectedDeviceType = '';
      selectedOS = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.lightBlue),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications_none,
                color: Colors.lightBlue,
                size: 30,
              ),
            )
          ],
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
                  image: AssetImage('image/hel.jpg'),
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
                  'Report You Issue',
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
                  reusableTextFild("Enter Issue Title", Icons.title, false,
                      _titleController),
                  const SizedBox(height: 15),
                  ReusableDropdownField(
                    hintText: 'Select the type of issue',
                    icon: Icons.category,
                    items: ['Hardware', 'Software', 'Networkig', 'Other'],
                    selectedItem: selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  ReusableTextareaFild(
                    controller: _descriptionController,
                    hintText: 'Type here Description of you issue...',
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
                  const SizedBox(height: 15),
                  ReusableDropdownField(
                    hintText: 'Select Device Type',
                    icon: Icons.devices,
                    items: ['Laptop', 'Desktop', 'Mobile', 'Tablet'],
                    selectedItem: selectedDeviceType,
                    onChanged: (value) {
                      setState(() {
                        selectedDeviceType = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  ReusableDropdownField(
                    hintText: 'Select Operating System',
                    icon: Icons.computer,
                    items: ['Windows', 'macOS', 'Linux', 'iOS', 'Android'],
                    selectedItem: selectedOS,
                    onChanged: (value) {
                      setState(() {
                        selectedOS = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  reusableTextFild("Enter Name of Your Office", Icons.warehouse,
                      false, _officeController),
                  const SizedBox(height: 10),
                  mybutton(context, "Request Support", () {
                    _requestSupport();
                  }),
                ],
              ),
            ),
          ),
        ])));
  }
}
