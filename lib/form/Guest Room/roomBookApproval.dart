import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/function/request/GuestRoomBook/RoombookTile.dart';

import 'package:hostel_app/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Status: Working Fine

/*
Display Dialog in which Request Detail Come
The RoomCount functionality is not working as expected. When approve button is pressed, a white screen appears momentarily.
*/

class RoomApproval extends StatefulWidget {
  RoomApproval({Key key, this.title}) : super(key: key);

  final String title;
  static String roomStatus = 'Pending';
  static bool read = false;
  @override
  _RoomApprovalState createState() => _RoomApprovalState();
}

class _RoomApprovalState extends State<RoomApproval> {


  final List<String> _roomStatus = [
    'Pending',
    'Approved',
    'Rejected',
  ];

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('roomBook')
        .where("roomStatus", isEqualTo: RoomApproval.roomStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "Guest Room Book Request",
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
                items: _roomStatus.map((String value) {
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
                    RoomApproval.roomStatus = value;
                  });
                },
                value: RoomApproval.roomStatus,
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
                  final requestDocs = reqSnapshot.data.documents;
                  print('length ${requestDocs.length}');
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: requestDocs.length,
                    itemBuilder: (ctx, index) {
                      return Column(
                        children: [
                          RoomBookTile(
                            request: requestDocs[index],
                            firestoreDB: firestoreDB,
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

