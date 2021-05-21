import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/function/adminHandle/hostelAdmin/updateInfo/hEmployeeUpdateForm.dart';

class UpdateEmployee extends StatefulWidget {
  @override
  _UpdateEmployeeState createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('hostel Employee')
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
                        return HEmployeeList(
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

class HEmployeeList extends StatefulWidget {
  final dynamic reqDoc;

  HEmployeeList({this.reqDoc});

  @override
  _HEmployeeListState createState() => _HEmployeeListState();
}

class _HEmployeeListState extends State<HEmployeeList> {
  @override
  Widget build(BuildContext context) {
    final userNameHostel = widget.reqDoc.get("userNameHostel");
    final role = widget.reqDoc.get("role");
    final empIdHostel = widget.reqDoc.get("empIdHostel");
    final designationHostel = widget.reqDoc.get("designationHostel");
    final uid = widget.reqDoc.get("hostelInChargeID");
    final ePhone = widget.reqDoc.get("contactNumberHostel");
    final eEmail = widget.reqDoc.get("personalEmailIdHostel");
    final adminCheck = widget.reqDoc.get("admin");
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
                              'Employee Name: ',
                              style: darkSmallTextBold,
// style: darkSmallTextBold,
                            ),
                            Text(
                              '$userNameHostel',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Employee ID: ',
                              style: darkSmallTextBold,
// style: darkSmallTextBold,
                            ),
                            Text(
                              '$empIdHostel',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Role: ',
                              style: darkSmallTextBold,
// style: darkSmallTextBold,
                            ),
                            Text('$role'),
                          ],
                        ),

                        Row(
                          children: [
                            Text(
                              'Designation: ',
                              style: darkSmallTextBold,
// style: darkSmallTextBold,
                            ),
                            Text(designationHostel),
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
                              builder: (context) => FUpdateForm(
                                    eDesignation: designationHostel,
                                    eEmail: eEmail,
                                    eID: empIdHostel,
                                    eName: userNameHostel,
                                    ePhone: ePhone,
                                    eRole: role,
                                    eUid: uid,
                                    admin: adminCheck,
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
