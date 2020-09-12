
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/view/dashboard/hostel_InCharge/dashboard_warden.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Approvals extends StatefulWidget {
  Approvals({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApprovalsState createState() => _ApprovalsState();
}



class _ApprovalsState extends State<Approvals> {

  static String approvalStatus = 'Pending';



  final List<String> _approvalStatus = [
    'Pending',
    'Approved',
    'Rejected',
  ];

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('outPass Form').where("approvalStatus", isEqualTo: approvalStatus)
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
                  MaterialPageRoute(
                      builder: (context) => HostelBar()),
                );
              })),
      body: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center  ,
            children: [
              Icon(
                Icons.sort,
                color: darkBlue,
                size: 25,
              ),
              Text("Sort By: ",style:TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Poppins') ,),
              SizedBox(width: 5,),
              DropdownButton(
                hint: Text('Pending'),
                items: _approvalStatus.map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style:TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Poppins',fontWeight: FontWeight.bold),),
                  );
                }).toList(),
                onChanged: (String value){
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
                builder: (ctx, reqSnapshot) {
                  if (reqSnapshot.connectionState == ConnectionState.waiting){
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
                          StudentTile(
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

class StudentTile extends StatefulWidget {
  StudentTile({this.request, this.firestoreDB});

  final dynamic request;
  final dynamic firestoreDB;

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  Future<void> _launched;
  String _phone = '+919977777678';
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController customController = TextEditingController();
  bool talkedToParent = false;
  String remarks;
  String approved = 'Pending';
  bool read = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void updateDocument() {
    FirebaseFirestore.instance
        .collection('outPass Form')
        .doc(widget.request.documentID)
        .update({});
  }

  Future<String> createAlertDialog(
      {BuildContext context,
      String studentName,
      String registrationNo,
      String requestID,
      String batch,
      String course,
      String block,
      String roomNo,
      String reason,
      String destination,
      String parentContactNumber,
      /*bool talkedToParent ,*/ String startDate,
      String endDate /*String remarks,bool approve=false*/,
      String transport}) {
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
                                  text: 'Reason : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: reason)
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
                                  text: 'End Date : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: endDate)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Destination : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: destination)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Transport : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: transport)
                            ],
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: kCardTextStyle,
                            children: [
                              TextSpan(
                                  text: 'Parent Contact No. : ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: parentContactNumber),
                            ],
                          ),
                        ),
                        RaisedButton(
                          onPressed: () => setState(() {
                            _launched = _makePhoneCall('tel:$parentContactNumber');
                          }),
                          child: const Text('Make phone call'),
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return CardInput(
                              toggleCheckBoxState: (bool value) {
                                setState(() {
                                  talkedToParent = value;
                                });
                              },
                              controller: customController,
                              checkBoxState: talkedToParent,
                              approved: approved,
                              approvedButtonState: () {
                                setState(() {
                                  approved = 'Approved';
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);

                                  FirebaseFirestore.instance
                                      .collection('outPass Form')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "approvalStatus": approved,
                                    "consentFrom": talkedToParent,
                                    "remark": remarks
                                  });

                                  approved == 'Approved'
                                      ? print('Approved!')
                                      : print('Rejected');
                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },
                              rejectedButtonState: () {
                                setState(() {
                                  approved = 'Rejected';
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);

                                  FirebaseFirestore.instance
                                      .collection('outPass Form')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "approvalStatus": approved,
                                    "consentFrom": talkedToParent,
                                    "remark": remarks
                                  }).then((value) => Navigator.pop(context));

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
                createAlertDialog(
                  context: context,
                  studentName: studData.get('studentName'),
                  registrationNo: studData.get('registrationNumber').toString(),
                  requestID: widget.request.documentID,
                  batch: studData.get('batch'),
                  course: studData.get('courseName'),
                  block: studData.get('block'),
                  roomNo: studData.get('roomNumber').toString(),
                  reason: widget.request.get('reason'),
                  destination: widget.request.get('destination'),
                  parentContactNumber:
                      studData.get('parentContactNumber').toString(),
                  /* talkedToParent: _model.talkedToParent,*/
                  startDate: (widget.request.get('startDate') as Timestamp)
                      .toDate()
                      .toString(),
                  endDate: (widget.request.get('endDate') as Timestamp)
                      .toDate()
                      .toString(),
                  transport: widget.request.get('modeOfTransport'),
                  /*remarks: _model.remarks, approve: _model.approve*/
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
                radius: 5.0,
                backgroundColor: read == false ? Colors.red : Colors.white),
          );
        });
  }
}

class CardInput extends StatelessWidget {
  final bool checkBoxState;
  final String remarks;
  final String approved;
  final Function toggleCheckBoxState;
  final Function approvedButtonState;
  final Function rejectedButtonState;
  final TextEditingController controller;

  CardInput(
      {this.checkBoxState,
      this.toggleCheckBoxState,
      this.controller,
      this.approved,
      this.approvedButtonState,
      this.rejectedButtonState,
      this.remarks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Talked To Parents: ", style: kCardTextStyle),
              SizedBox(
                width: 10,
              ),
              Checkbox(
                activeColor: Colors.blue[600],
                value: checkBoxState,
                onChanged: (toggleCheckBoxState),
              ),
            ],
          ),
          TextField(
              controller: controller,
              decoration: kTextFieldDecoration.copyWith(labelText: 'Remarks')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.white,
                    child: Text('Reject', style: kbuttonTextStyle),
                    onPressed: rejectedButtonState),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.white,
                    child: Text('Approve', style: kbuttonTextStyle),
                    onPressed: approvedButtonState),
              )
            ],
          )
        ],
      ),
    );
  }
}
