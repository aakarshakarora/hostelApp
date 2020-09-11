import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/form/outPass_form.dart';
import 'package:hostel_app/login/loginScreen.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/view/dashboard/student/outpass_status.dart';
import 'package:hostel_app/view/mess/menu.dart';
import '../../mess/menu.dart';
import 'package:hostel_app/view/futurePage/upcoming.dart';

class DashboardStudent extends StatefulWidget {
  @override
  _DashboardStudentState createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  final titles = [
    'Apply for OutPass',
    'Mess Menu',
    'Service Request',
    'Laundry Cycles'
  ];

  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.local_dining),
    Icon(Icons.settings),
    Icon(Icons.local_laundry_service)
  ];

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
    super.initState();
    test = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkerBlue,
      body: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('student').doc(test).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            Map<String, dynamic> data = snapshot.data.data();
            return Container(
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Welcome " + data['studentName'],

                            style: lightHeading,
                            // style: TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 20,
                            // ),
                          ),
                          FlatButton.icon(
                            onPressed: () {
                              signOut();
                              Navigator.of(context, rootNavigator: true)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => LoginPage()));
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
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.7,
                        color: Colors.white70,
                      ),
                      Flexible(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: titles.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                color: white, //change
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      titleIcon[index],
                                      Text(
                                        titles[index],
                                        style: darkHeading,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OutPassForm()),
                                  );
                                } else if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessMenu()),
                                  );
                                } else if (index == 2 || index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Upcoming()),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'View OutPass Status',
                            style: darkSmallTextBold,
                          ),
                          color: peach,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OutpassStatus()),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
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
