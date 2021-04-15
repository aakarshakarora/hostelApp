import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Status: Working Fine[Cloud Function Required to Improve Efficacy]

/*
Handle Room Count on the basis of Guest Room Approvals
 */

// ignore: must_be_immutable
class RoomCount extends StatefulWidget {
  String roomType;

  RoomCount(this.roomType, this.roomRequest);

  int roomRequest;
  int result = 0, getRoom = 0;

  @override
  _RoomCountState createState() => _RoomCountState();
}

class _RoomCountState extends State<RoomCount> {
  int roomReduce(int roomRequest, int roomCount) {
    if (roomCount == 0) {
      print("Room Count is Zero");
      return 0;
    } else {
      if (roomRequest > roomCount) {
        print("Room Not Available as per Requirement");

        return roomCount;
      } else {
        print("Book Room as Per Room Request");
        roomCount = roomCount - roomRequest;
        return roomCount;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('roomAvailable')
                .doc(widget.roomType)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              Map<String, dynamic> data = snapshot.data.data();
              widget.result = roomReduce(widget.roomRequest, data['roomCount']);
              widget.getRoom = data['roomCount'];

              return StatefulBuilder(builder:
                  // ignore: missing_return
                  (BuildContext context, StateSetter setState) {
                // ignore: missing_return
                widget.result = roomReduce(widget.roomRequest, data['roomCount']);
                FirebaseFirestore.instance
                    .collection("roomAvailable")
                    .doc(widget.roomType)
                    .set({'roomCount': widget.result}).then(
                        (value) => Navigator.of(context).pop());
              });
            }),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.result = roomReduce(widget.roomRequest, widget.getRoom);
  }
}
