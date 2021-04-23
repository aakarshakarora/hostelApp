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

class Approvals extends StatefulWidget {
  Approvals({Key key, this.title}) : super(key: key);

  final String title;
  static String approvalStatus = 'Pending';
  @override
  _ApprovalsState createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals> {
  final List<String> _approvalStatus = [
    'Pending',
    'Approved',
    'Rejected',
    'Processing'
  ];

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('outPass Form')
        .where("approvalStatus", isEqualTo: Approvals.approvalStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "OutPass Request",
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
                    Approvals.approvalStatus = value;
                  });
                },
                value: Approvals.approvalStatus,
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
                            passType: 'OutPass',
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
