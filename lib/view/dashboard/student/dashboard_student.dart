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

  @override
  void initState() {
    super.initState();
    currentUser = getCurrentUser();
  }

  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: darkerBlue,
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
            return Container(
              width: MediaQuery.of(context).size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container()),
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
                      Flexible(
                        child: Text(
                          'Welcome ${data['studentName']}',
                          style: lightHeading,
                        ),
                      ),
                      Divider(
                        thickness: 0.7,
                        color: Colors.white70,
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              cycles = data['Cycles'];
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
                              } else if (index == 2) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RoomTypes()),
                                );
                              } else if (index == 3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LaundryCycles(cycles)),
                                );
                              }
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'OutPass Status',
                                style: darkSmallTextBold.copyWith(fontSize: 12),
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: RaisedButton(
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Guest Room Status',
                                style: darkSmallTextBold.copyWith(fontSize: 12),
                              ),
                              color: peach,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GuestRoomStatus()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: RaisedButton(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Day Pass Status',
                            style: darkSmallTextBold.copyWith(fontSize: 12),
                          ),
                          color: peach,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DaypassStatus()),
                            );
                          },
                        ),
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
