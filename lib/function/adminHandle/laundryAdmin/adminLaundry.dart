import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class AdminLaundry extends StatefulWidget {
  @override
  _AdminLaundryState createState() => _AdminLaundryState();
}

class _AdminLaundryState extends State<AdminLaundry> {
  bool hasLaundry;

  @override
  void initState() {
    hasLaundry = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text("Add Student", style: lightHeading),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Has Laundry Plan:"),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Yes",
                    ),
                    Radio<bool>(
                        groupValue: hasLaundry,
                        value: true,
                        onChanged: (v) {
                          setState(() {
                            hasLaundry = v;
                          });
                        }),
                    Text(
                      "No",
                    ),
                    Radio<bool>(
                        groupValue: hasLaundry,
                        value: false,
                        onChanged: (v) {
                          setState(() {
                            hasLaundry = v;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('student')
                    .where('laundryCheck', isEqualTo: hasLaundry)
                    .snapshots(),
                builder: (ctx, opSnapshot) {
                  if (opSnapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final reqDocs = opSnapshot.data.documents;
                  print('length ${reqDocs.length}');

                  return ListView.builder(
                    itemCount: reqDocs.length,
                    itemBuilder: (ctx, index) {
                      if (opSnapshot.hasData)
                        return StudentCard(
                          reqDoc: reqDocs[index],
                          laundryCheck: hasLaundry,
                        );
                      return Container(
                        height: 0,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final dynamic reqDoc;
  final bool laundryCheck;

  StudentCard({this.reqDoc, this.laundryCheck});

  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  bool planType;

  @override
  void initState() {
    planType = true;
    planName = 30;
    super.initState();
  }

  dynamic mentorFirestoreDB;
  String bagID;
  int planName;
  final bagIDController = TextEditingController();

  _buildBagID() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: bagIDController,
        decoration:
            InputDecoration(hintText: "W250", labelText: 'Enter Bag ID:'),

        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Field is required';
          }
        },
        onSaved: (String value) {
          bagID = value;
        },
      ),
    );
  }

  Widget _buildCycles() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "30 Cycles",
            ),
            Radio<bool>(
                groupValue: planType,
                value: true,
                onChanged: (v) {
                  setState(() {
                    planType = v;
                    planName = 30;
                  });
                }),
            Text(
              "15 Cycles",
            ),
            Radio<bool>(
                groupValue: planType,
                value: false,
                onChanged: (v) {
                  setState(() {
                    planType = v;
                    planName = 15;
                  });
                }),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentName = widget.reqDoc.get("studentName");
    final courseName = widget.reqDoc.get("courseName");
    final regNo = widget.reqDoc.get("registrationNumber");
    final roomNumber = widget.reqDoc.get("roomNumber");
    final block = widget.reqDoc.get("block");
    final uid = widget.reqDoc.get("studentID");

    return widget.laundryCheck == true
        ? Container(
            padding: const EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Student Name: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(
                                  '$studentName',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Registration Number: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(
                                  '$regNo',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Course Name: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text('$courseName'),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  'Block-Room Number: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(block + "-" + roomNumber),
                              ],
                            ),

                            // ignore: deprecated_member_use
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: MaterialButton(
                              onPressed: () {
                                _showRemoveDialog(studentName, uid);
                              },
                              child: Icon(Icons.remove_circle_outline),
                            )),
                            Text(
                              "Remove User",
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                )))
        : Container(
            padding: const EdgeInsets.all(10),
            child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Student Name: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(
                                  '$studentName',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Registration Number: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(
                                  '$regNo',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Course Name: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text('$courseName'),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  'Block-Room Number: ',
                                  style: darkSmallTextBold,
                                  // style: darkSmallTextBold,
                                ),
                                Text(block + "-" + roomNumber),
                              ],
                            ),

                            // ignore: deprecated_member_use
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: MaterialButton(
                              onPressed: () {
                                _showApproveDialog(uid);
                              },
                              child: Icon(Icons.group_add),
                            )),
                            Text(
                              "Add User",
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                )));
  }

  Future<void> _showApproveDialog(String uid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add User'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  _buildBagID(),
                  _buildCycles(),
                ],
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                print(uid);
                print(planName);
                print(bagIDController.text);
                setState(() {
                  FirebaseFirestore.instance
                      .collection('student')
                      .doc(uid)
                      .update({
                    "laundryCheck": true,
                    "Cycles": planName,
                    "laundryStatus": 'Active',
                    "bagID": bagIDController.text,

                  });
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRemoveDialog(String uName, String uid) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove User'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Do You Want to Remove: $uName from Laundry Service")
                ],
              ),
            );
          }),
          actions: <Widget>[
            TextButton(
              child: Text('Remove'),
              onPressed: () {
                setState(() {
                  FirebaseFirestore.instance
                      .collection('student')
                      .doc(uid)
                      .update({
                    "laundryCheck": false,
                    "Cycles": null,
                    "laundryStatus": 'Inactive',
                    "bagID": "",
                  });
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
