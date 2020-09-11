import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String test;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          body: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .doc(test)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                Map<String, dynamic> data = snapshot.data.data();
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Course Name: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['courseName'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Registration Number: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['registrationNumber'].toString(),
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Contact Number: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['studentContactNumber'].toString(),
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Student Email ID: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['studentEmailID'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class ParentDetail extends StatefulWidget {
  @override
  _ParentDetailState createState() => _ParentDetailState();
}

class _ParentDetailState extends State<ParentDetail> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String test;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          body: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .doc(test)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                Map<String, dynamic> data = snapshot.data.data();

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Parent Name: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['parentName'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Parent Contact Number: ",
                              style: darkSmallTextBold),
                          Text(
                            data['parentContactNumber'].toString(),
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Parent Email ID: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['parentEmailID'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

class MentorDetail extends StatefulWidget {
  @override
  _MentorDetailState createState() => _MentorDetailState();
}

class _MentorDetailState extends State<MentorDetail> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String test;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Scaffold(
          body: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('student')
                  .doc(test)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                Map<String, dynamic> data = snapshot.data.data();

                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Row(
                        children: [
                          Text(
                            "Mentor Name: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['mentorName'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Mentor Contact Number: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['mentorContactNumber'].toString(),
                            style: darkSmallText,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Mentor Email ID: ",
                            style: darkSmallTextBold,
                          ),
                          Text(
                            data['mentorEmailId'],
                            style: darkSmallText,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
