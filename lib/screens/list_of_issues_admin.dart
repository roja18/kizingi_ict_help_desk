import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'issue_detail.dart';

class ListIssuesPage extends StatefulWidget {
  const ListIssuesPage({super.key});

  @override
  State<ListIssuesPage> createState() => _ListIssuesPageState();
}

class _ListIssuesPageState extends State<ListIssuesPage> {
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
                    "Admin Panel",
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
                      const Text(
                        'Technical Request List',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 5, right: 5, bottom: 20),
                        child: FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('requests')
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              return Center(child: Text('No requests found'));
                            } else if (snapshot.hasData) {
                              var requests = snapshot.data!.docs;

                              return Column(
                                children: requests.map((doc) {
                                  var data = doc.data() as Map<String, dynamic>;
                                  var documentId = doc.id; // Get document ID
                                  var tileColor = data['feedback'] == null
                                      ? getPriorityColor(data['priority'])
                                      : Colors.white;
                                  return Card(
                                    color: tileColor,
                                    child: ListTile(
                                      title: Text(data['title']),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data['description']),
                                          Divider(),
                                          Text(
                                              'Level of certification: ${data['feedback']}'),
                                        ],
                                      ),
                                      trailing: Text(data['status']),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                IssueDetailPage(
                                              issueData: data,
                                              documentId: documentId,
                                            ),
                                          ),
                                        );
                                      },
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
