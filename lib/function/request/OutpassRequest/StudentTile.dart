import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../form/OutPass/outPassRequest/outpass_approval.dart';
import '../../../theme/theme.dart';
import 'OutpassCardUpdate.dart';
//Status: Working fine
//The out pass requests will be visible in the form of these tiles.

class StudentTile extends StatefulWidget {
  StudentTile({this.request, this.firestoreDB, this.passType});

  final dynamic request;
  final dynamic firestoreDB;
  final String passType;

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /*
  Auto  Generated Email on the basis of Approvals from Warden Side

  From Warden to Parent + Mentor

   */

  Future<void> send(
      String parentEmail, mentorEmail, studentName, status, room, block) async {
    final Email email = Email(
      body: "Greetings of the Day!!\n" +
          studentName +
          " resident of MUJ Hostel \n Room Number: " +
          room +
          " Block: " +
          block +
          "\n has Applied for OutPass Approval and It has Been " +
          status +
          " by CareTaker \n\n Thanks,\n CareTaker MUJ",
      subject: "OutPass Approval Request by " + studentName,
      recipients: [parentEmail],
      cc: [mentorEmail],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(platformResponse),
    ));
  }

  /*
  Phone Call Button on Card
  This Button will Navigate to Student's Parent Contact Number on the basis of Request ID
   */
  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController customController = TextEditingController();
  bool talkedToParent = false;
  String remarks, remarkF = "";
  String approved;
  bool read = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
      String parentEmail,
      String mentorEmail,
      String parentContactNumber,
      String startDate,
      String endDate,
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
                          thickness: 0.7,
                          color: darkerBlue,
                        ),
                        Center(
                            child:
                                Text('DAY PASS DETAILS', style: darkHeading)),
                        Divider(
                          thickness: 0.7,
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
                        Divider(
                          thickness: 0.7,
                          color: darkerBlue,
                        ),
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                                color: darkerBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: MaterialButton(
                              textColor: Colors.white,
                              child:
                                  Text('Call Parent', style: kbuttonTextStyle),
                              onPressed: () => setState(() {
                                _launched =
                                    _makePhoneCall('tel:$parentContactNumber');
                              }),
                            ),
                          ),
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return OutPassCardUpdate(
                              toggleCheckBoxState: (bool value) {
                                setState(() {
                                  talkedToParent = value;
                                });
                              },
                              passType: widget.passType,
                              read: read,
                              controller: customController,
                              checkBoxState: talkedToParent,
                              approved: approved,

                              //Request Has been Approved
                              approvedButtonState: () {
                                setState(() {
                                  approved = 'Approved';
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);
                                  final collectionName =
                                      widget.passType == 'OutPass'
                                          ? 'outPass Form'
                                          : 'dayPassForm';
                                  FirebaseFirestore.instance
                                      .collection(collectionName)
                                      .doc(widget.request.id)
                                      .update({
                                    "approvalStatus": approved,
                                    "consentFrom": talkedToParent,
                                    "remark": remarks,
                                  });

                                  customController.text = "";

                                  approved == 'Approved'
                                      ? print('Approved!')
                                      : print('Rejected');
                                  // send(parentEmail, mentorEmail, studentName,
                                  //     approved, roomNo, block);
                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },

                              //Request Has Been Rejected
                              rejectedButtonState: () {
                                setState(() {
                                  approved = 'Rejected';
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);
                                  final collectionName =
                                  widget.passType == 'OutPass'
                                      ? 'outPass Form'
                                      : 'dayPassForm';
                                  FirebaseFirestore.instance
                                      .collection(collectionName)
                                      .doc(widget.request.id)
                                      .update({
                                    "approvalStatus": approved,
                                    "consentFrom": talkedToParent,
                                    "remark": remarks,
                                  });

                                  customController.text = "";

                                  approved == 'Rejected'
                                      ? print('Rejected!')
                                      : print('Approved');
                                  // send(parentEmail, mentorEmail, studentName,
                                  //     approved, roomNo, block);
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
    final collectionName =
        widget.passType == 'OutPass' ? 'outPass Form' : 'dayPassForm';
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
                    .collection(collectionName)
                    .doc(widget.request.id)
                    .update({
                  "read": read,
                });
                createAlertDialog(
                  context: context,
                  studentName: studData.get('studentName'),
                  registrationNo: studData.get('registrationNumber').toString(),
                  requestID: widget.request.id,
                  batch: studData.get('batch'),
                  course: studData.get('courseName'),
                  parentEmail: studData.get('parentEmailID'),
                  mentorEmail: studData.get('mentorEmailId'),
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
              "Request ID: ${widget.request.id}",
              style: greySmallText,
            ),
            trailing: CircleAvatar(
                radius: 5.0,
                backgroundColor: widget.request.get('read') == false &&
                        Approvals.approvalStatus == 'Pending'
                    ? Colors.red
                    : Colors.white),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    customController.dispose();
  }
}
