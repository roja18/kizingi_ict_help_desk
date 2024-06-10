import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'component/reusable_widget.dart';

class IssueDetailPage extends StatelessWidget {
  final Map<String, dynamic> issueData;
  final String documentId; // Add this line to receive documentId

  const IssueDetailPage(
      {super.key, required this.issueData, required this.documentId});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = (issueData['timestamp'] as Timestamp).toDate();

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

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
                padding: EdgeInsets.only(top: 40, left: 25.0, right: 25.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    'image/problem.png',
                                    width: 100,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Request Title: ${issueData['title']}',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Category: ${issueData['category']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Description: ${issueData['description']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Device with Problem: ${issueData['deviceType']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Device Operating System: ${issueData['operatingSystem']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Time: $formattedDate',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Priority: ${issueData['priority']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Solving Status: ${issueData['status']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '- Office problem occure: ${issueData['office']}',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(height: 10),
                                mybutton(context, "Accept Request", () async {
                                  // Update the request status in Firestore
                                  await FirebaseFirestore.instance
                                      .collection('requests')
                                      .doc(documentId)
                                      .update({'status': 'Work On'});
                                }),
                                mybutton(
                                    context, "Provide Alternative Solution",
                                    () {
                                  _showCommentDialog(context, documentId);
                                }),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showCommentDialog(BuildContext context, String documentId) {
  String comment = ''; // Variable to hold the user's comment

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Provide Alternative Solution'),
        content: TextField(
          onChanged: (value) {
            comment = value; // Update the comment variable as user types
          },
          decoration: InputDecoration(
            hintText: 'Enter your alternative solution...',
          ),
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
                  .update({'comment': comment});

              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Submit'),
          ),
        ],
      );
    },
  );
}
