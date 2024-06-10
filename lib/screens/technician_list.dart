import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'technician.dart';

class ListOfTechnician extends StatefulWidget {
  const ListOfTechnician({super.key});

  @override
  State<ListOfTechnician> createState() => _ListOfTechnicianState();
}

class _ListOfTechnicianState extends State<ListOfTechnician> {
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
                padding: const EdgeInsets.only(top: 40, left: 5.0, right: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'List of Technicians',
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
                              .collection('users')
                              .where('usertype')
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              return Center(
                                  child: Text('No technicians found'));
                            } else if (snapshot.hasData) {
                              var technicians = snapshot.data!.docs;

                              return Column(
                                children: technicians.map((doc) {
                                  var data = doc.data() as Map<String, dynamic>;
                                  return Card(
                                    child: ListTile(
                                      title: Text(data['fullname']),
                                      subtitle: Text(data['email']),
                                      trailing: Column(
                                        children: [
                                          Text(data['usertype']),
                                          Text(data['registration']),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Center(
                                  child: Text('No technicians found'));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TechnicianPage()));
          },
          label: Row(
            children: [
              Icon(Icons.add_box),
              Text(' Add Technician'),
            ],
          )),
    );
  }
}
