import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/function/request/OutpassRequest/StudentTile.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Status: Working Fine

/*
Display Dialog in which Request Detail Come
*/

class DayPassApprovals extends StatefulWidget {
  DayPassApprovals({Key key, this.title}) : super(key: key);

  final String title;
  static String approvalStatus = 'Pending';
  @override
  _DayPassApprovalsState createState() => _DayPassApprovalsState();
}

class _DayPassApprovalsState extends State<DayPassApprovals> {
  final List<String> _approvalStatus = [
    'Pending',
    'Approved',
    'Rejected',
  ];

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('dayPassForm')
        .where("approvalStatus", isEqualTo: DayPassApprovals.approvalStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "Day Pass Request",
            style: lightHeading,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HostelBar()),
                );
              })),
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
                    DayPassApprovals.approvalStatus = value;
                  });
                },
                value: DayPassApprovals.approvalStatus,
              ),
            ],
          ),
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: firestoreDB,
                builder: (ctx, reqSnapshot) {
                  if (reqSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final requestDocs = reqSnapshot.data.docs;
                  print('length ${requestDocs.length}');
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: requestDocs.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          StudentTile(
                            request: requestDocs[index],
                            firestoreDB: firestoreDB,
                            passType: 'DayPass',
                          ),
                          Divider(
                            height: 12,
                          ),
                        ],
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
