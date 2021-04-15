import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/rendering.dart';

//Status: Working Fine

/*
Display QR Code When OutPass Request has been Approved
 */

// ignore: must_be_immutable
class GeneratePage extends StatefulWidget {
  String reqId, sDate, eDate, dest, reason;

  GeneratePage(this.reqId, this.sDate, this.eDate, this.dest, this.reason);

  @override
  _GeneratePageState createState() => _GeneratePageState();
}

class _GeneratePageState extends State<GeneratePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUser = getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code',
          style: lightHeading,
        ),
        centerTitle: true,
        backgroundColor: darkerBlue,
      ),
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
              padding: EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Student Name: ",
                        style: darkSmallTextBold,
                      ),
                      Text(
                        data['studentName'].toString(),
                        style: darkSmallText,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Program Name: ",
                        style: darkSmallTextBold,
                      ),
                      Text(
                        data['courseName'].toString(),
                        style: darkSmallText,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Block - Room Number: ",
                        style: darkSmallTextBold,
                      ),
                      Text(
                        data['block'].toString(),
                        style: darkSmallText,
                      ),
                      Text(
                        "-" + data['roomNumber'].toString(),
                        style: darkSmallText,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Scan To See Request ID, OutPass Duration, Destination, Reason ",
                          style: darkSmallTextBold,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  QrImage(
                    data: widget.reqId
                  ),
                ],
              ),
            );
          }),
    );
  }
}
