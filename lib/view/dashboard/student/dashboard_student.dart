import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/form/Laundry/addRequest.dart';
import 'package:hostel_app/form/OutPass/outPass_form.dart';
import 'package:hostel_app/function/mess/menu.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/view/dashboard/student/outpass_status.dart';
import 'package:hostel_app/view/dashboard/student/roomStatus.dart';
import 'package:hostel_app/view/dashboard/student/roomTypes.dart';
import 'package:hostel_app/view/dashboard/student/daypass_status.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import 'package:url_launcher/url_launcher.dart';

//Status: Working Fine

/*
Dashboard of Student
*/

class DashboardStudent extends StatefulWidget {
  @override
  _DashboardStudentState createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent>
    with AutomaticKeepAliveClientMixin {
  int cycles;
  String name;

  @override
  bool get wantKeepAlive => true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final titles = [
    'Apply for OutPass',
    'Mess Menu',
    'Guest Room Book',
    'Laundry Cycles'
  ];
  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.local_dining),
    Icon(Icons.hotel),
    Icon(Icons.local_laundry_service)
  ];

  String currentUser;

//Get Current User
  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    currentUser = getCurrentUser();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('student')
              .doc(currentUser)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> data = snapshot.data.data();
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60.0),
                              ),
                              border: Border.all(
                                width: 1,
                                color: Colors.black26,
                                style: BorderStyle.solid,
                              )),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Hello!',
                                    style: darkLargeHeading,
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      signOut();
                                      Navigator.of(context, rootNavigator: true)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      color: Colors.black38,
                                    ),
                                    /* label: Text(
                                      'Logout',
                                      style: lightSmallText,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: white,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50)), */
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${data['studentName']}',
                                    textAlign: TextAlign.start,
                                    textDirection: ui.TextDirection.ltr,
                                    style: darkHeading,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      data['block'] +
                                          "-" +
                                          data['roomNumber'].toString(),
                                      style: greyHeading),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 1,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                      data['occupancyType'] +
                                          '\t' +
                                          'Occupancy',
                                      style: greyHeading),
                                  Spacer(),
                                  MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: darkpurple,
                                      onPressed: () {
                                        if (data['block'][0] == "G") {
                                          _makePhoneCall("tel:+917727006783");
                                        } else if (data['block'][0] == "B") {
                                          _makePhoneCall("tel:+917727006782");
                                        }
                                      },
                                      child: Text(
                                        'Call CareTaker',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ],
                              )
                              /*Row(
                                children: [
                                  Expanded(child: Container()),
                                  FlatButton.icon(
                                    onPressed: () {
                                      signOut();
                                      Navigator.of(context, rootNavigator: true)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    icon: Icon(
                                      Icons.exit_to_app,
                                      color: white,
                                    ),
                                    label: Text(
                                      'Logout',
                                      style: lightSmallText,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: white,
                                            width: 1,
                                            style: BorderStyle.solid),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ),
                                ],
                              ), */
                            ],
                          ),
                        ),
                        /*  Flexible(
                          child: Text(
                            'Welcome ${data['studentName']}',
                            style: lightHeading,
                          ), 
                        ),
                        Divider(
                          thickness: 0.7,
                          color: Colors.white70,
                        ), */
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: darkpurple,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessMenu()),
                                  );
                                },
                                child: Text(
                                  'Mess Menu',
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: darkpurple,
                                onPressed: () {},
                                child: Text(
                                  'Food Outlet',
                                  style: TextStyle(color: Colors.white),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Apply For:',
                          style: darkLargeHeading,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OutPassForm()),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/outpass.png")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'OutPass',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: 10,
                              ),
                              /*  InkWell(
                                onTap: () => {},
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/roomservice.jpg")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Room Service',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),
                              ), 
                              SizedBox(
                                width: 10,
                              ), */
                              InkWell(
                                onTap: () => Navigator.push(

                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoomTypes()),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/guestroom.jpg")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Guest Room',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Request Status:',
                          style: darkLargeHeading,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(

                                      builder: (context) => OutpassStatus()),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/outpass.png")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'OutPass',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),

                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DaypassStatus()),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/daypass.jpg")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Day Pass',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GuestRoomStatus()),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/guestroom.jpg")),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(60.0),
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                            style: BorderStyle.solid,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Guest Room',
                                      style: darkHeading,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                            minWidth: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: darkpurple,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                       LaundryCycles(cycles, name)),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  'Laundry',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  data['Cycles'].toString() +
                                      '\t' +
                                      'Cycles Left',
                                  style: lightTinyText,
                                )
                              ],
                            )),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

signOut() {
  FirebaseAuth.instance.signOut();
}
