import 'package:flutter/material.dart';

import 'component/my_drawer.dart';

class OtherAssistance extends StatefulWidget {
  const OtherAssistance({super.key});

  @override
  State<OtherAssistance> createState() => _OtherAssistanceState();
}

class _OtherAssistanceState extends State<OtherAssistance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'ICT Help Assistance',
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
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('image/ctech.png'),
                        ),
                        Text("You can also contact us through"),
                        Text("Contact : 0786 009 901"),
                        Text("www.kizingitech.com")
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ])));
  }
}
