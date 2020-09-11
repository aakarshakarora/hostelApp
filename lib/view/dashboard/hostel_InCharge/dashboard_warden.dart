import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/form/outPassRequest/outpass_approval.dart';
import 'package:hostel_app/login/loginScreen.dart';
import 'package:hostel_app/view/futurePage/upcoming.dart';
import 'package:hostel_app/theme/theme.dart';

class DashboardHostelInCharge extends StatefulWidget {
  @override
  _DashboardHostelInChargeState createState() =>
      _DashboardHostelInChargeState();
}

class _DashboardHostelInChargeState extends State<DashboardHostelInCharge> {
  final titles = ['Outpass Requests', 'Service Requests'];
  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.settings),
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
    // TODO: implement initState
    super.initState();
    test = getCurrentUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkerBlue,
      body: FutureBuilder<DocumentSnapshot>(
          future:
              FirebaseFirestore.instance.collection('hostelInCharge').doc(test).get(),
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
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome ' + data['userNameHostel'],
                            style: lightHeading,
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
                        color: white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: titles.length,
                          itemBuilder: (ctx, index) {
                            return InkWell(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                color: white,
                                child: Container(
                                  height: 100,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Approvals()),
                                  );
                                } else {
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
