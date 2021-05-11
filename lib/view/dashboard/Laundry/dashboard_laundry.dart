import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/function/Laundry/finishRequest.dart';
import 'package:hostel_app/function/Laundry/processRequest.dart';
import 'package:hostel_app/function/Laundry/recievedRequest.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Dashboard of Hostel In Charge
*/

class DashboardLaundryInCharge extends StatefulWidget {
  @override
  _DashboardLaundryInChargeState createState() =>
      _DashboardLaundryInChargeState();
}

class _DashboardLaundryInChargeState extends State<DashboardLaundryInCharge>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final titles = ['Received Request', 'On Going Requests', 'Finished Request'];
  final titleIcon = [
    Icon(Icons.today),
    Icon(Icons.update),
    Icon(Icons.assignment)
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
    // TODO: implement initState

    super.initState();
    currentUser = getCurrentUser();
  }

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
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Container()),
                              // ignore: deprecated_member_use
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
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          'Welcome ${data['userNameHostel']}',
                          style: lightHeading,
                        ),
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
                                  height: 90,
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
                                        builder: (context) => ManageRequest()),
                                  );
                                } else if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProcessRequest()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FinishRequest()),
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
