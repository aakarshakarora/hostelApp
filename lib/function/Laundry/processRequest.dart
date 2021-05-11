import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/common/bottomBar/navigationBarLaundry.dart';
import 'package:hostel_app/theme/theme.dart';


class ProcessRequest extends StatefulWidget {
  ProcessRequest({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProcessRequestState createState() => _ProcessRequestState();
}

class _ProcessRequestState extends State<ProcessRequest> {
  static String currentStatus = 'Received';

  Widget build(BuildContext context) {
    var firestoreDB = FirebaseFirestore.instance
        .collection('LaundryRequest')
        .where('status', isEqualTo: currentStatus)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "On Going Request",
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold
            ),
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

  TextEditingController shirt = new TextEditingController();
  TextEditingController trouser = new TextEditingController();
  TextEditingController handkerchief = new TextEditingController();
  TextEditingController socks = new TextEditingController();
  TextEditingController bedSheet = new TextEditingController();
  TextEditingController pillowCover = new TextEditingController();
  TextEditingController upperInnerWear = new TextEditingController();
  TextEditingController lowerInnerWear = new TextEditingController();
  TextEditingController towel = new TextEditingController();
  TextEditingController handTowel = new TextEditingController();
  TextEditingController remarks = new TextEditingController();
  TextEditingController miscellaneous = new TextEditingController();

  Future<String> createAlertDialog({
    BuildContext context,
    String userName,
    String requestID,
    int cycles,
    String contactNumber,
    String email,
    String block,
    approveStatus,
    String roomNo,
    String requestDate,
    clothCount,
    String studentID,
  }) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(10),
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  child: Container(
                    child: Column(
                      children: [
                        Text("Enter Cloth Count",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Shirt:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: shirt,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Trouser:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: trouser,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Handkerchief:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: handkerchief,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Socks:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: socks,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Towel:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: towel,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Hand Towel:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: handTowel,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Bed Sheet:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: bedSheet,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'PillowCover:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: pillowCover,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Upper Inner Wear:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: upperInnerWear,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Lower Inner Wear:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: lowerInnerWear,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Miscellaneous:',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.phone,
                          controller: miscellaneous,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Remarks :',
                              labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Poppins',
                              )
                          ),
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          controller: remarks,
                        ),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return CardInput(
                              approvedButtonState: () {
                                setState(() {
                                  approveStatus = 'Processing';

                                  FirebaseFirestore.instance
                                      .collection('LaundryRequest')
                                      .doc(widget.request.documentID)
                                      .update({
                                    "status": approveStatus,
                                    "shirt":shirt.text,
                                    "trouser":trouser.text,
                                    "handkerchief":handkerchief.text,
                                    "socks":socks.text,
                                    "bedSheet":bedSheet.text,
                                    "pillowCover":pillowCover.text,
                                    "upperIW":upperInnerWear.text,
                                    "lowerIW":lowerInnerWear.text,
                                    "miscellaneous":miscellaneous.text,
                                    "remarks":remarks.text,
                                  });

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
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  (widget.request.get('requestDate') as Timestamp)
                      .toDate()
                      .toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Poppins'
                  ),
                ),
              ],
            ),
            subtitle: Text(
              "Request ID: ${widget.request.documentID}",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16
              ),
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
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.black,
                    child: Text(
                      'Washing ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.white
                      ),
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
