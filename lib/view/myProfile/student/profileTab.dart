import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Student My Profile -> Student Details
*/

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
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
                  return Center(child: CircularProgressIndicator());
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

//Status: Working Fine

/*
Student My Profile -> Parent Details
*/

class ParentDetail extends StatefulWidget {
  @override
  _ParentDetailState createState() => _ParentDetailState();
}

class _ParentDetailState extends State<ParentDetail> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
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
                  return Center(child: CircularProgressIndicator());
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

//Status: Working Fine

/*
Student My Profile -> Mentor Details
*/

class MentorDetail extends StatefulWidget {
  @override
  _MentorDetailState createState() => _MentorDetailState();
}

class _MentorDetailState extends State<MentorDetail> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
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
    super.build(context);
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
                  return Center(child: CircularProgressIndicator());
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
