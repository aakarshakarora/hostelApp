import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Hostel In Charge My Profile
*/

class ProfileSecGuard extends StatefulWidget {
  @override
  _ProfileSecGuardState createState() => _ProfileSecGuardState();
}

class _ProfileSecGuardState extends State<ProfileSecGuard> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

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
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          backgroundColor: white,
          body: FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('hostel Employee')
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
                            //User Profile Photo and UserName
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/profile1.jpg"))),
                                ),
                                SizedBox(width: 50),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(data['userNameHostel'],
                                        style: lightHeading),
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
                                    Text(data['designationHostel'],
                                        style: lightSmallText),
                                    Text("Designation", style: lightTinyText),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(data['empIdHostel'],
                                        style: lightSmallText),
                                    Text("Employee ID", style: lightTinyText),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: peach,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "EDIT PROFILE",
                                      style: TextStyle(
                                          color: peach,
                                          fontSize: 13,
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
                        padding: const EdgeInsets.all(10),
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
                              child:
                              Text("User Information", style: darkHeading),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Text("Designation: ", style: darkSmallTextBold),
                                Text(
                                  data['designationHostel'],
                                  style: darkSmallText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Employee ID: ", style: darkSmallTextBold),
                                Text(
                                  data['empIdHostel'],
                                  style: darkSmallText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Contact Number: ",
                                    style: darkSmallTextBold),
                                Text(
                                  data['contactNumberHostel'].toString(),
                                  style: darkSmallText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Work Email ID: ",
                                    style: darkSmallTextBold),
                                Text(
                                  data['collegeEmailIdHostel'],
                                  style: darkSmallText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Personal Email ID: ",
                                    style: darkSmallTextBold),
                                Text(
                                  data['personalEmailIdHostel'],
                                  style: darkSmallText,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
