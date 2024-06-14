import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'component/my_drawer.dart';
import 'component/reusable_widget.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  User? user;
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  Color getPriorityColor(String priority) {
    switch (priority) {
      case 'Low':
        return Colors.green;
      case 'Medium':
        return Colors.yellow;
      case 'High':
        return Colors.orange;
      case 'Critical':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showCommentDialog(BuildContext context, String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please rate the service'),
          content: ReusableDropdownField(
            hintText: 'Select satification class',
            icon: Icons.category,
            items: ['Excellent', 'Very Good', 'Good', 'Normal', 'Bald'],
            selectedItem: selectedCategory,
            onChanged: (value) {
              setState(() {
                selectedCategory = value ?? '';
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Update the Firestore document with the entered comment
                await FirebaseFirestore.instance
                    .collection('requests')
                    .doc(documentId)
                    .update({'feedback': selectedCategory, 'status': 'Done'});

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'ICT Help Respond',
          style: TextStyle(color: Colors.lightBlue),
        ),
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Reported Issues',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('requests')
                    .where('userId', isEqualTo: user?.uid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No requests found'));
                  } else if (snapshot.hasData) {
                    var requests = snapshot.data!.docs;

                    return Column(
                      children: requests.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        String documentId = doc.id;
                        var tileColor = data['feedback'] == null
                            ? getPriorityColor(data['priority'])
                            : Colors.white;
                        return Card(
                          color: tileColor,
                          child: ListTile(
                            title: Text(data['title']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data['description']),
                                Text(
                                  'Do this: ${data['comment']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Divider(),
                                Text(data['status'])
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _showCommentDialog(context, documentId);
                              },
                              icon: Icon(Icons.feedback),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Center(child: Text('No requests found'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
