import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/common/bottomBar/navigationBarLaundry.dart';
import 'package:hostel_app/theme/theme.dart';


import 'package:url_launcher/url_launcher.dart';

class ManageRequest extends StatefulWidget {
  ManageRequest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ManageRequestState createState() => _ManageRequestState();
}

class _ManageRequestState extends State<ManageRequest> {
  static String currentStatus = 'Pending';

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('LaundryRequest')
        .where('status', isEqualTo: currentStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "Recieved Request",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaundryBar()),
                );
              })),
      body: Column(
        children: [
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
                          OrderRequest(
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

class OrderRequest extends StatefulWidget {
  OrderRequest({this.request, this.firestoreDB});

  final dynamic request;
  final dynamic firestoreDB;

  @override
  _OrderRequestState createState() => _OrderRequestState();
}

class _OrderRequestState extends State<OrderRequest> {
  TextEditingController customController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void updateDocument() {
    FirebaseFirestore.instance
        .collection('LaundryRequest')
        .doc(widget.request.documentID)
        .update({});
  }

  Future<String> createAlertDialog(
      {BuildContext context,
        String userName,
        String requestID,
        String contactNumber,
        String email,
        String block,
        String roomNo,
        String requestDate,
        String plan,
        studentID,
        clothCount,
        int cycles,
        approveStatus}) {
    print(userName);
    print(requestID);
    print(contactNumber);
    print(email);
    print(block);
    print(roomNo);
    print(requestDate);
    print(studentID);
    print(clothCount);
    print(cycles);print(approveStatus);

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
                child: SingleChildScrollView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          userName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            height: 3,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          "Cloth Count: " + clothCount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Block: " + block + "\t\t\tRoom Number: " + roomNo,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Email ID:\t\t " + email,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Contact Number: \t\t" + contactNumber,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Request ID:\t\t " + requestID,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Request Date: " + requestDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Cycles Count left: " + cycles.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        Text(
                          "Plan Status: " + plan,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "*Click on Received if You have Received Laundry Bag",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 17,
                              color: Colors.red),
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return CardInput(
                              approvedButtonState: () {
                                setState(() {
                                  approveStatus = 'Received';
                                  cycles--;

                                  FirebaseFirestore.instance
                                      .collection('LaundryRequest')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "status": approveStatus,
                                  });
                                  FirebaseFirestore.instance
                                      .collection('student')
                                      .doc(studentID)
                                      .update({
                                    "Cycles": cycles,
                                  });

                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },
                              rejectedButtonState: () {
                                setState(() {
                                  approveStatus = 'Rejected';

                                  FirebaseFirestore.instance
                                      .collection('LaundryRequest')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "status": approveStatus,
                                  }).then((value) => Navigator.pop(context));

                                  approveStatus == 'Received'
                                      ? print('Received!')
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
                createAlertDialog(
                  context: context,
                  userName: studData.get('studentName'),
                  plan: studData.get('laundryStatus'),
                  cycles: studData.get('Cycles'),
                  requestID: widget.request.documentID,
                  email: studData.get('studentEmailID'),
                  studentID: studData.get('studentID'),
                  contactNumber: studData.get('studentContactNumber'),
                  block: studData.get('block'),
                  roomNo: studData.get('roomNumber'),
                  clothCount: widget.request.get('clothCount').toString(),

                  /* talkedToParent: _model.talkedToParent,*/
                  requestDate: (widget.request.get('requestDate') as Timestamp)
                      .toDate()
                      .toString(),

                  /*remarks: _model.remarks, approve: _model.approve*/
                );
              });
            },
//            leading: CircleAvatar(
//              radius: 24.0,
//              backgroundImage: AssetImage("assets/food.png"),
//            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  studData.get('studentName'),
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  (widget.request.get('requestDate') as Timestamp)
                      .toDate()
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300, fontFamily: 'Poppins'),
                ),
              ],
            ),
            subtitle: Text(
              "Request ID: ${widget.request.documentID}",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
            ),
//            trailing: CircleAvatar(
//                radius: 5.0,
//                backgroundColor: read == false ? Colors.red : Colors.white),
          );
        });
  }
}

//
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.black,
                    child: Text(
                      'Reject',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: rejectedButtonState),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.black,
                    child: Text(
                      'Received',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: approvedButtonState),
              )
            ],
          )
        ],
      ),
    );
  }
}
