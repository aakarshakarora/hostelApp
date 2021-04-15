import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/form/Guest Room/roomBookApproval.dart';
import '../../roomCountHandle/roomCount.dart';
import 'RoomCardUpdate.dart';

//Status: Working fine
//The room book approval requests are displayed individually by these tiles

class RoomBookTile extends StatefulWidget {
  RoomBookTile({this.request, this.firestoreDB});

  final dynamic request;
  final dynamic firestoreDB;

  @override
  _RoomBookTileState createState() => _RoomBookTileState();
}

class _RoomBookTileState extends State<RoomBookTile> {
  TextEditingController customController = TextEditingController();
  String remarks;
  String approved = 'Pending';
  bool read = false;


  //This function creates an alert dialog displaying the booking details, remarks textfield and buttons to approve/reject
  Future<String> createAlertDialog({
    BuildContext context,
    String studentName,
    String registrationNo,
    String requestID,
    String batch,
    String course,
    String block,
    String roomNo,
    String guestName,
    String guestRelation,
    String purpose,
    String guestAddress,
    String dayCount,
    String startDate,
    String roomCount,
    String roomType,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(5),
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 0.85,
                child: SingleChildScrollView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(studentName, style: requestCardHeading),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Registration No. : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: registrationNo)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Course : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: course)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Batch : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: batch)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Block : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: block)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Room No. : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: roomNo)
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: darkerBlue,
                        ),
                        Center(
                          child: Text(
                            'BOOKING DEATILS',
                            style: darkHeading,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: darkerBlue,
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Request Id : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: requestID)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Guest Name : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: guestName)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Guest Relation: ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: guestRelation)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Purpose: ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: purpose)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Room Type : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: roomType)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Start Date : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: startDate)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Day Count : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: dayCount),
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Room Count : ',
                                  style:
                                  TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: roomCount),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.7,
                          color: darkerBlue,
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return RoomCardUpdate(
                              read: read,
                              controller: customController,
                              approved: approved,
                              approvedButtonState: () {
                                setState(() {
                                  approved = 'Approved';
                                  remarks = customController.text;

                                  print(remarks);

                                  FirebaseFirestore.instance
                                      .collection('roomBook')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "roomStatus": approved,
                                    "remark": remarks,
                                  });

                                  customController.text = "";

                                  approved == 'Approved'
                                      ? print('Approved!')
                                      : print('Rejected');
                                  print("room count check");

                                  print("room count ");
                                  // ignore: missing_return
                                  Navigator.of(context, rootNavigator: true)
                                      .pushReplacement(MaterialPageRoute(
                                      builder: (context) => RoomCount(
                                          roomType,
                                          int.parse(widget.request
                                              .get('roomRequest')))));
                                });
                              },
                              rejectedButtonState: () {
                                setState(() {
                                  approved = 'Rejected';
                                  remarks = customController.text;

                                  print(remarks);

                                  FirebaseFirestore.instance
                                      .collection('roomBook')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "roomStatus": approved,
                                    "remark": remarks,
                                  });

                                  customController.text = "";
                                  approved == 'Approved'
                                      ? print('Approved!')
                                      : print('Rejected');

                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },
                            );
                          },
                        ),
                        FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('roomAvailable')
                                .doc(roomType)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              Map<String, dynamic> data = snapshot.data.data();
                              return Center(
                                child: Column(
                                  children: [
                                    Text("Room Available"),
                                    Text(roomType +
                                        " Room: " +
                                        data['roomCount'].toString()),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final ref = widget.request.get('studentID');

    return StreamBuilder(
        stream: ref.snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          final studData = snapshot.data;
          return ListTile(
            onTap: () {
              setState(() {
                read = true;
                FirebaseFirestore.instance
                    .collection('roomBook')
                    .doc(widget.request.documentID)
                    .update({
                  "read": read,
                });
                createAlertDialog(
                  context: context,
                  studentName: studData.get('studentName'),
                  registrationNo: studData.get('registrationNumber').toString(),
                  batch: studData.get('batch'),
                  course: studData.get('courseName'),
                  block: studData.get('block'),
                  roomNo: studData.get('roomNumber').toString(),
                  requestID: widget.request.documentID,
                  guestName: widget.request.get('guestName'),
                  guestRelation: widget.request.get('guestRelation'),
                  purpose: widget.request.get('purpose'),
                  guestAddress: widget.request.get('guestAddress'),
                  dayCount: widget.request.get('dayCount').toString(),
                  roomCount: widget.request.get('roomRequest'),
                  roomType: widget.request.get('roomType'),
                  startDate: (widget.request.get('startDate') as Timestamp)
                      .toDate()
                      .toString(),
                );
              });
            },
            leading: CircleAvatar(
              radius: 24.0,
              backgroundImage: AssetImage("assets/food.png"),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  studData.get('studentName'),
                  style: darkSmallTextBold,
                ),
                Text(
                  (widget.request.get('requestDate') as Timestamp)
                      .toDate()
                      .toString(),
                  style: darkTinyText,
                ),
              ],
            ),
            subtitle: Text(
              "Request ID: ${widget.request.documentID}",
              style: greySmallText,
            ),
            trailing: CircleAvatar(
                radius: 5,
                backgroundColor: widget.request.get('read') == false &&
                    RoomApproval.roomStatus == 'Pending'
                    ? Colors.red
                    : Colors.white),
          );
        });
  }

}