import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/function/adminHandle/hostelAdmin/updateInfo/studentUpdateForm.dart';

class UpdateStudent extends StatefulWidget {
  @override
  _UpdateStudentState createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('student')
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
                        return StudentListCard(
                          reqDoc: reqDocs[index],
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

class StudentListCard extends StatefulWidget {
  final dynamic reqDoc;

  StudentListCard({this.reqDoc});

  @override
  _StudentListCardState createState() => _StudentListCardState();
}

class _StudentListCardState extends State<StudentListCard> {
  @override
  Widget build(BuildContext context) {
    final studentName = widget.reqDoc.get("studentName");
    final courseName = widget.reqDoc.get("courseName");
    final regNo = widget.reqDoc.get("registrationNumber");
    final roomNumber = widget.reqDoc.get("roomNumber");
    final block = widget.reqDoc.get("block");
    final uid = widget.reqDoc.get("studentID");
    final roomType = widget.reqDoc.get("occupancyType");
    final pName = widget.reqDoc.get("parentName");
    final pPhone = widget.reqDoc.get("parentContactNumber");
    final pEmail = widget.reqDoc.get("parentEmailID");
    return Container(
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
                    GestureDetector(
                        child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SUpdateForm(
                                    pEmail: pEmail,
                                    pName: pName,
                                    pPhone: pPhone,
                                    roomBlock: block,
                                    roomNo: roomNumber,
                                    roomType: roomType,
                                    sCourse: courseName,
                                    sName: studentName,
                                    sRegNo: regNo,
                                    sUid: uid,
                                  )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.update),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Update Information",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    )),
                  ]),
                ),
              ),
            )));
  }
}
