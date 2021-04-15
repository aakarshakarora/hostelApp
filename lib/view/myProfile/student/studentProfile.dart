import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'profileTab.dart';

//Status: Working Fine

/*
Student My Profile
*/

class ProfileStudent extends StatefulWidget {
  @override
  _ProfileStudentState createState() => _ProfileStudentState();
}

class _ProfileStudentState extends State<ProfileStudent> with AutomaticKeepAliveClientMixin<ProfileStudent> {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  String currentUser;

  //Check Current User
  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = getCurrentUser();
  }

  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Added
      length: 3, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: white,
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('student')
                .doc(currentUser)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              Map<String, dynamic> data = snapshot.data.data();
              return Stack(
                // ignore: deprecated_member_use
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: darkerBlue,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 3, top: 50),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            AssetImage("assets/profile.jpg"))),
                              ),
                              SizedBox(width: 50),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(data['studentName'],
                                      //snapshot.data['studentName'],
                                      style: lightHeading),
                                  SizedBox(height: 15),
                                  Row(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airline_seat_individual_suite,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                              data['block'] +
                                                  "-" +
                                                  data['roomNumber'].toString(),
                                              style: lightTinyText),
                                        ],
                                      ),
                                      SizedBox(width: 12),
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.airline_seat_individual_suite,
                                            color: Colors.white,
                                            size: 24.0,
                                          ),
                                          SizedBox(width: 12),
                                          Text(data['occupancyType'],
                                              style: lightTinyText),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(data['courseName'],
                                      style: lightSmallText),
                                  Text("Program", style: lightTinyText),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(data['registrationNumber'].toString(),
                                      style: lightSmallText),
                                  Text("Registration Number",
                                      style: lightTinyText),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: peach),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "EDIT PROFILE",
                                    style: TextStyle(
                                        color: peach,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 230),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          )),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, top: 20),
                            child: Text("User Information", style: darkHeading),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 40,
                            child: TabBar(
                              indicatorColor: peach,
                              tabs: [
                                Tab(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "User Details",
                                      style: darkSmallTextBold.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Parent Details",
                                      style: darkSmallTextBold.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Mentor Details",
                                      style: darkSmallTextBold.copyWith(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Expanded(
                              child: Container(
                                child: TabBarView(
                                  children: [
                                    UserDetail(),
                                    ParentDetail(),
                                    MentorDetail(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

//
                ],
              );
            }),
      ),
    );
  }
}
