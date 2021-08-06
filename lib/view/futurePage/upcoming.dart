import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Upcoming Page
*/

class Upcoming extends StatefulWidget {
  final String outPassID, scanType;

  Upcoming(this.outPassID, this.scanType);

  //1: get the id from qr
  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  Future<List> _getStudentDetail(DocumentReference documentReference) async {
    var ref = await documentReference.get();
    List details = [
      ref.data()['studentName'],
      ref.data()['block'],
      ref.data()['registrationNumber'],
      ref.data()['courseName'],
      ref.data()['roomNumber']
    ];
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkerBlue,
            title: Text(
              "Gate Pass Check",
              style: lightSmallText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          body: FutureBuilder<DocumentSnapshot>(
              //2 fecth outpass doc from firestore: today list//has all the outpasses
              future: FirebaseFirestore.instance
                  .collection('outPass-today')
                  //ALERT: needs to be CHANGED TO outpass-today after the cloud function is in use
                  .doc(widget.outPassID)
                  .get()
                  .onError((error, stackTrace) => null),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> data = snapshot.data.data();
                if (data != null) {
                  DocumentReference studentRef = data['studentID'];
                  bool check = applyOutpassChecks(data);
                  bool studentIn = data['studentStatus'] == 'in' ? true : false;
                  return Container(
                      padding: EdgeInsets.all(50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: FutureBuilder(
                                future: _getStudentDetail(studentRef),
                                builder: (BuildContext context,
                                    AsyncSnapshot<List> snapshot) {
                                  if (snapshot.hasData)
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "OutPass ID: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              widget.outPassID,
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Gate Pass Type: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              widget.scanType,
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 45,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Student Name: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              snapshot.data[0],
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Registration Number: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              snapshot.data[1].toString(),
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Course Name: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              snapshot.data[2].toString(),
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Block - Room Number: ",
                                              style: darkSmallTextBold,
                                            ),
                                            Text(
                                              snapshot.data[3].toString(),
                                              style: darkSmallText,
                                            ),
                                            Text(
                                              "-" + snapshot.data[4].toString(),
                                              style: darkSmallText,
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  else
                                    return CircularProgressIndicator();
                                }),
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "OutPass Details ",
                                  style: darkSmallTextBold,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Status: ",
                                style: darkSmallTextBold,
                              ),
                              Text(
                                data['approvalStatus'],
                                style: darkSmallText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Start Date: ",
                                style: darkSmallTextBold,
                              ),
                              Text(
                                (data['startDate'] as Timestamp)
                                    .toDate()
                                    .toString(),
                                style: darkSmallText,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "End Date: ",
                                style: darkSmallTextBold,
                              ),
                              Text(
                                (data['endDate'] as Timestamp)
                                    .toDate()
                                    .toString(),
                                style: darkSmallText,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            color:
                                check ? Colors.greenAccent : Colors.redAccent,
                            child: Text(check
                                ? "Allowed to check ${studentIn ? "out" : "in"}"
                                : "Not allowed to check ${studentIn ? "out" : "in"}"),
                          ),
                          ElevatedButton(
                              onPressed: check
                                  ? () => doDbWork(data, context, studentIn)
                                  : null,
                              child: Text("Check ${studentIn ? "out" : "in"}")),
                        ],
                      ));
                } else
                  return (Text("INVALID QR: couldn't fetch student details"));
              })),
      onWillPop: () {
        Navigator.pop(context);
        Navigator.pop(context);
        return Future.value(true);
      },
    );
  }

  void doDbWork(
      Map<String, dynamic> data, BuildContext context, bool studentIn) {
    if (studentIn) {
      //  ALLOWED => change studentStatus to out && add to checked out collection
      FirebaseFirestore.instance
          .collection('outPass-today')
          .doc(widget.outPassID)
          .update({'studentStatus': 'out'});

      data.update('studentStatus', (value) => 'out');
      print(data);
      FirebaseFirestore.instance
          .collection('outPass-checked-out')
          .doc(widget.outPassID)
          .set(data)
          .onError((error, stackTrace) => print(error))
          .then((value) {
        print("STUDENT CHECKED OUT");
      });
      message('Student Checked Out : HAVE A SAFE JOURNEY!',context);
    } else {
      // ALLOWED => change studentStatus to returned in today list && move to outpass-returned
      FirebaseFirestore.instance
          .collection('outPass-today')
          .doc(widget.outPassID)
          .update({'studentStatus': 'returned'});

      data.update('studentStatus', (value) => 'returned');
      print(data);
      FirebaseFirestore.instance
          .collection('outPass-returned')
          .doc(widget.outPassID)
          .set(data)
          .onError((error, stackTrace) => print(error))
          .then((value) {
        print("STUDENT CHECKED IN");
      });
      message('Student Checked IN : WELCOME BACK!', context);
    }
  }

  void message(String message, BuildContext context) {
    //make changes to the current page according to the message and timeout to home in a few seconds
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      backgroundColor: Colors.green,
      content: Row(
        children: [Icon(Icons.check,size: 20,color: Colors.white,), Text(message)],
      ),
      duration: Duration(seconds: 3),
    ));
    Timer(Duration(seconds: 4), () {
      Navigator.pop(context);
      Navigator.pop(context);
    });
    return;
  }

  bool applyOutpassChecks(Map<String, dynamic> data) {
    // 3 check if outgoing or incoming (in or out) (using studentStatus tag)
    if (data['studentStatus'] == 'in')
      //4 if outgoing: check if approved :ALLOWED else :NOT ALLOWED
      return (data['approvalStatus'] == 'Approved') ? true : false;
    else if (data['studentStatus'] == 'out')
      // 4 if incoming :check if before the end date :ALLOWED else: NOT ALLOWED
      return ((data['endDate'] as Timestamp).toDate().isAfter(DateTime.now()))
          ? true
          : false;
    else
      return false; //if empty or returned :don't allow
  }
}
/*
* ALGORITHM
* 1 get the id from qr
* 2 fecth outpass doc from firestore: today list//has all the outpasses
* 3 check if outgoing or incoming (in or out) (using studentStatus tag)
* 4 if outgoing: check if approved :ALLOWED => add to checked out collection && change studentStatus to out
* else :NOT ALLOWED
* 4 if incoming :check if before the end date :ALLOWED => move to outpass-returned && change studentStatus to returned
*  else: NOT ALLOWED
*/

//when we're comparing end date with today in dart MAKE SURE : the END time and Start Time is 12 am
//so everyone is allowed to check in without considering time as dart compares timestamp accurate to time /not date

// todo : delete the checked out list document after check in
