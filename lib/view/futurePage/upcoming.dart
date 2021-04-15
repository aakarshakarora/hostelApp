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

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  static String sName, sBlock, courseName;
  static String sRno, sRegNo;

  _getStudentDetail(DocumentReference documentReference) async {
    await documentReference.get().then((value) {
      setState(() {
        sName = value.data()['studentName'];
        sBlock = value.data()['block'];
        sRegNo = value.data()['registrationNumber'];
        courseName = value.data()['courseName'];

        sRno = value.data()['roomNumber'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Doc ID IS:" + widget.outPassID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text(
          "Gate Pass Check",
          style: lightSmallText.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('outPass Form')
              .doc(widget.outPassID)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> data = snapshot.data.data();
            DocumentReference studentRef = data['studentID'];

            _getStudentDetail(studentRef);
            return Container(
                padding: EdgeInsets.all(50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Student Name: ",
                          style: darkSmallTextBold,
                        ),
                        Text(
                          sName,
                          style: darkSmallText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Registration Number: ",
                          style: darkSmallTextBold,
                        ),
                        Text(
                          sRegNo.toString(),
                          style: darkSmallText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Course Name: ",
                          style: darkSmallTextBold,
                        ),
                        Text(
                          courseName.toString(),
                          style: darkSmallText,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Block - Room Number: ",
                          style: darkSmallTextBold,
                        ),
                        Text(
                          sBlock.toString(),
                          style: darkSmallText,
                        ),
                        Text(
                          "-" + sRno.toString(),
                          style: darkSmallText,
                        ),
                      ],
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
                          (data['startDate'] as Timestamp).toDate().toString(),
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
                          (data['endDate'] as Timestamp).toDate().toString(),
                          style: darkSmallText,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          onPressed: () {},
                          child: Text("Yes"),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("No"),
                        ),
                      ],
                    )
                  ],
                ));
          }),
    );
  }
}
