import 'package:flutter/material.dart';
import 'package:hostel_app/function/qrScan/genQR.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../theme/theme.dart';
import 'package:rxdart/rxdart.dart';

//Status: Working Fine

/*
OutPass Status Overview
*/

class DaypassStatus extends StatefulWidget {
  @override
  _DaypassStatusState createState() => _DaypassStatusState();
}

class _DaypassStatusState extends State<DaypassStatus> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  static String approvalStatus = 'Pending';

  final List<String> _approvalStatus = [
    'Pending',
    'Approved',
    'Rejected',
    'Processing'
  ];

  @override
  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('dayPassForm')
        .where("approvalStatus", isEqualTo: approvalStatus)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Day Pass Status',
          style: lightHeading,
        ),
        centerTitle: true,
        backgroundColor: darkerBlue,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sort,
                color: darkBlue,
                size: 25,
              ),
              Text(
                "Sort By: ",
                style: TextStyle(
                    fontSize: 15, color: Colors.black, fontFamily: 'Poppins'),
              ),
              SizedBox(
                width: 5,
              ),
              DropdownButton(
                hint: Text('Pending'),
                items: _approvalStatus.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    approvalStatus = value;
                  });
                },
                value: approvalStatus,
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: firestoreDB,
                builder: (ctx, opSnapshot) {
                  if (opSnapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final reqDocs = opSnapshot.data.docs;
                  print(reqDocs);
                  print('length ${reqDocs.length}');
                  return ListView.builder(
                    itemCount: reqDocs.length,
                    itemBuilder: (ctx, index) {
                      if (reqDocs[index]
                          .get('studentID')
                          .toString()
                          .contains(userId))
                        return StatusCard(reqDoc: reqDocs[index]);
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

//Status: Working Fine

/*
OutPass Details in Details
*/

class StatusCard extends StatefulWidget {
  StatusCard({this.reqDoc});

  final dynamic reqDoc;

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  String requestDate =
      DateFormat.yMMMMEEEEd().format(new DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final requestId = widget.reqDoc.id;
    final sDate =
        (widget.reqDoc.get("startDate") as Timestamp).toDate().toString();
    final eDate =
        (widget.reqDoc.get("endDate") as Timestamp).toDate().toString();
    final dest = widget.reqDoc.get("destination");
    final reason = widget.reqDoc.get("reason");

    String approvalStatus = widget.reqDoc.get('approvalStatus');
    bool _approved = false;
    if (approvalStatus == 'Approved') _approved = true;
    String remark;
    if (approvalStatus != 'Pending') remark = widget.reqDoc.get('remark');

    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: _approved ? 250 : 200,
        width: double.infinity,
        child: Card(
          elevation: 5,
          color: white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Request Id :',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      '$requestId',
                      style: darkTinyText,
                    ),
                    Text(
                      'on $requestDate',
                      style: darkTinyText,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment,
                            color: Colors.green,
                            size: 30,
                          ),
                          Text(
                            'Applied',
                            style: darkTinyText,
                          )
                        ],
                      ),
                    ),
                    Text('----------',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        )),
                    Icon(
                      Icons.person,
                      color: Colors.green,
                      size: 30,
                    ),
                    if (approvalStatus == 'Approved')
                      Text(
                        '----------',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                        ),
                      )
                    else if (approvalStatus == 'Rejected')
                      Text(
                        '----------',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      )
                    else
                      Text(
                        '----------',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),

                    //icon
                    if (approvalStatus == 'Approved')
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 30,
                            ),
                            Text(
                              'Accepted',
                              style: darkTinyText,
                            )
                          ],
                        ),
                      )
                    else if (approvalStatus == 'Rejected')
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            Icon(
                              Icons.block,
                              color: Colors.red,
                              size: 30,
                            ),
                            Text(
                              'Rejected',
                              style: darkTinyText,
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          children: [
                            Icon(
                              Icons.remove_circle,
                              color: Colors.grey,
                              size: 30,
                            ),
                            Text(
                              'Pending',
                              style: darkTinyText,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                if (approvalStatus != 'Pending')
                  Text('Remarks: $remark', style: darkSmallText),
                if (_approved)
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: peach,
                    child: Text(
                      'Show QR Code',
                      style: darkSmallTextBold,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneratePage(
                                requestId, sDate, eDate, dest, reason)),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
