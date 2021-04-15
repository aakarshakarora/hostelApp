import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/form/mess/messUpdateForm.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Dashboard of Mess In Charge
*/

class DashboardMessOperator extends StatefulWidget {
  @override
  _DashboardMessOperatorState createState() => _DashboardMessOperatorState();
}

class _DashboardMessOperatorState extends State<DashboardMessOperator> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final titles = ['Update Mess Menu', 'Student Food Rating'];
  final titleIcon = [
    Icon(Icons.local_dining),
    Icon(Icons.rate_review),
  ];

  String currentUser;

  //Fetches the current user from firebase
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: darkerBlue,
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('hostel Employee')
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 35, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        "Welcome " + data['userNameHostel'],
                        style: lightHeading,
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.7,
                      color: Colors.white70,
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
                            ),
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MessUpdate()));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

//Signs the user out

signOut() {
  FirebaseAuth.instance.signOut();
}
