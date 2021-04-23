import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
RoomBook Status Overview
*/

class GuestRoomStatus extends StatefulWidget {
  @override
  _GuestRoomStatusState createState() => _GuestRoomStatusState();
}

class _GuestRoomStatusState extends State<GuestRoomStatus> {
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
        .collection('roomBook')
        .where("roomStatus", isEqualTo: approvalStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text(
          'Room Status',
          style: lightHeading,
        ),
        centerTitle: true,
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
                  print('length ${reqDocs.length}');
                  return ListView.builder(
                    itemCount: reqDocs.length,
                    itemBuilder: (ctx, index) {
                      if (reqDocs[index]
                          .get('studentID')
                          .toString()
                          .contains(userId))
                        return RoomStatusCard(reqDoc: reqDocs[index]);
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
RoomBook Status Details in Details
*/
class RoomStatusCard extends StatefulWidget {
  const RoomStatusCard({Key key, this.reqDoc}) : super(key: key);
  @override
  _RoomStatusCardState createState() => _RoomStatusCardState();
  final dynamic reqDoc;
}

class _RoomStatusCardState extends State<RoomStatusCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final requestId = widget.reqDoc.id;
    final startDate =
        (widget.reqDoc.get("startDate") as Timestamp).toDate().toString();
    final requestDate =
        (widget.reqDoc.get("requestDate") as Timestamp).toDate().toString();
    final guestName = widget.reqDoc.get("guestName");
    final roomType = widget.reqDoc.get("roomType");
    final roomRequest = widget.reqDoc.get("roomRequest");
    final dayCount = widget.reqDoc.get("dayCount");
    final roomFare = widget.reqDoc.get("roomFare");
    String status = widget.reqDoc.get('roomStatus');
    final guestRelation = widget.reqDoc.get('guestRelation');
    final guestAddress = widget.reqDoc.get('guestAddress');
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: expanded ? 575 : 290,
      child: Card(
        elevation: 4,
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/room.jpeg"),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Booking for $roomType Room',
                                style: darkSmallTextBold,
                              ),
                              Text(
                                'At New Door Hostel, MUJ',
                                style: darkSmallTextBold.copyWith(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.7,
                      ),
                      Text(
                        'Request ID $requestId',
                        style: darkSmallTextBold,
                      ),
                      Text(
                        'on $requestDate',
                        style: darkSmallTextBold,
                      ),
                      SizedBox(
                        height: 10,
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
                          if (status == 'Approved')
                            Text(
                              '----------',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                            )
                          else if (status == 'Rejected')
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
                          if (status == 'Approved')
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
                          else if (status == 'Rejected')
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
                    ],
                  ),
                ),
              ),
              if (!expanded)
                IconButton(
                  tooltip: 'View Booking Details',
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                ),
              if (expanded)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 0.7,
                    ),
                    Center(
                      child: Text(
                        'BOOKING DETAILS',
                        style: darkSmallTextBold.copyWith(fontSize: 18),
                      ),
                    ),
                    Divider(
                      thickness: 0.7,
                    ),
                    Text(
                      'Guest Name : ${guestName.toUpperCase()}',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Relation : $guestRelation',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Address : $guestAddress',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Number of rooms : $roomRequest',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Check In : $startDate',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Number of days : $dayCount',
                      style: darkSmallTextBold,
                    ),
                    Text(
                      'Total Cost : ₹$roomFare',
                      style: darkSmallTextBold,
                    ),
                    Divider(
                      thickness: 0.7,
                    ),
                    if (status == 'Approved')
                      Text(
                        'Note : Amount is payable at the time of arrival.',
                        style: darkSmallTextBold.copyWith(
                            color: Colors.grey, fontSize: 12),
                      ),
                    if (status == 'Rejected')
                      Text(
                        'Note : Your booking has been rejected. Please contact us for further details.',
                        style: darkSmallTextBold.copyWith(
                            color: Colors.red, fontSize: 12),
                      ),
                    if (status == 'Pending')
                      Text(
                        'Note : Your booking has not been confirmed yet. Please check again in some time.',
                        style: darkSmallTextBold.copyWith(
                            color: Colors.grey, fontSize: 12),
                      ),
                  ],
                ),
              if (expanded)
                IconButton(
                  tooltip: 'Hide Booking Details',
                  icon: Icon(Icons.keyboard_arrow_up),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
