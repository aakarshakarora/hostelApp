import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../theme/theme.dart';

class OutpassStatus extends StatefulWidget {
  @override
  _OutpassStatusState createState() => _OutpassStatusState();
}

class _OutpassStatusState extends State<OutpassStatus> {
  final userId = FirebaseAuth.instance.currentUser.uid;
  static String approvalStatus = 'Pending';

  final List<String> _approvalStatus = [
    'Pending',
    'Approved',
    'Rejected',
  ];

  @override
  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('outPass Form')
        .where("approvalStatus", isEqualTo: approvalStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OutPass Status',
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
                  final reqDocs = opSnapshot.data.documents;
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
                      'View PDF',
                      style: darkSmallTextBold,
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
