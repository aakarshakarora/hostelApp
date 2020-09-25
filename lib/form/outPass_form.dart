import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:intl/intl.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
class OutPassForm extends StatefulWidget {
  @override
  _OutPassFormState createState() => _OutPassFormState();
}

class _OutPassFormState extends State<OutPassForm> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  static String studentID;

  @override
  void initState() {
    super.initState();
    studentID = getCurrentUser();

  }


  String destination;
  final destinationController = TextEditingController();
  String reason;
  final reasonController = TextEditingController();
  DateTime startDate;
  DateTime endDate;
  bool startDateError = false;
  bool endDateError = false;
  String approvalStatus="Pending";
  DateTime requestDate=DateTime.now();
  String modeOfTransport;
  String consentFrom;

//  final dbRef = FirebaseDatabase.instance.reference().child("outPass Form");
  final List<String> _consentFrom = [
    'Yes',
    'No',
  ];

  final List<String> _modeOfTransport = [
    'Train',
    'Flight',
    'Road',
    'Other',
  ];

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
      'Request Sent Successfully',
      style: TextStyle(fontFamily: 'Poppins'),
    ));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _displayError(BuildContext context, onError) {
    final snackBar = SnackBar(
        content: Text(
      onError,
      style: TextStyle(fontFamily: 'Poppins'),
    ));
  }

  Future<DateTime> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().toLocal(),
        firstDate: DateTime.now().toLocal(),
        lastDate: endDate ?? DateTime(2100));
    return picked.toLocal();
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(DateTime.utc(0)),
      context: context,
    );
    return selectedTime;
  }

  Future<DateTime> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: startDate ?? DateTime.now().toLocal(),
        firstDate: startDate ?? DateTime.now().toLocal(),
        lastDate: DateTime(2100));
    return picked.toLocal();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDestinationField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: destinationController,
        decoration: kTextFieldDecoration.copyWith(
            labelText: 'Enter Destination Address:'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Address is required';
          }
        },
        onSaved: (String value) {
          destination = value;
        },
      ),
    );
  }

  Widget _buildReasonField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: reasonController,
        decoration: kTextFieldDecoration.copyWith(labelText: 'Enter a reason:'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Reason is required';
          }
        },
        onSaved: (String value) {
          reason = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef = FirebaseFirestore.instance.collection('student').doc(studentID);
    setState(() {
      print(docRef.toString());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        centerTitle: true,
        title: Text(
          'OutPass Form',
          style:
              TextStyle(fontFamily: 'PoppinsBold', fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildReasonField(),
                _buildDestinationField(),
                Row(
                  children: [
                    Text("Mode of Transport:",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    DropdownButton(
                      hint: Text(
                        'Select',
                        style: TextStyle(color: Colors.black),
                      ),

                      //dropdownColor: AppColor.background,
                      items: _modeOfTransport.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,

                          child: Text(value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          modeOfTransport = value;
                        });
                      },
                      value: modeOfTransport,

                    ),
                  ],
                ),
                //SizedBox(width: 30),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('From:',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        //SizedBox(width: 0.1),
                        Column(
                          children: [
                            Container(
                              height: 41,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
//                                border: Border.all(
//                                    color: Color.fromRGBO(248, 248, 255, 1)),
                              ),
                              child: FlatButton(
                                onPressed: () async {
                                  await _startDate(context).then((value) {
                                    if (endDate == null ||
                                        (endDate != null &&
                                            value.isBefore(endDate))) {
                                      setState(() {
                                        startDate = value.add(Duration(
                                            hours: startDate != null
                                                ? startDate.hour
                                                : 0,
                                            minutes: startDate != null
                                                ? startDate.minute
                                                : 0));
                                      });
                                    } else if (endDate != null) {
                                      setState(() {
                                        startDate = endDate;
                                      });
                                    }
                                  });
                                  if (startDate != null) {
                                    await _selectTime(context).then((value) {
                                      if (value != null) {
                                        var newDate = startDate.add(Duration(
                                            hours: value.hour - startDate.hour,
                                            minutes: value.minute -
                                                startDate.minute));
                                        if (endDate != null &&
                                            newDate.isBefore(endDate)) {
                                          setState(() {
                                            startDate = newDate;
                                          });
                                        } else if (endDate == null) {
                                          setState(() {
                                            startDate = newDate;
                                          });
                                        } else {
                                          setState(() {
                                            startDate = endDate;
                                          });
                                        }
                                      }
                                    });
                                  }
                                },
                                child: Text(
                                    startDate != null
                                        ? DateFormat('d MMM y on h:mm a')
                                            .format(startDate)
                                        : 'Select Date & Time',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                        fontSize: 13,
                                        color: Colors.black)),
                              ),
                            ),
                            startDateError
                                ? Text(
                                    "Start Time is Required",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.red,
                                        fontSize: 11),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border:
                            Border.all(color: Color.fromRGBO(248, 248, 255, 1)),
                      ),
                      child: FlatButton(
                        onPressed: () async {
                          await _endDate(context).then((value) {
                            if (startDate == null ||
                                (startDate != null &&
                                    value.isAfter(startDate))) {
                              setState(() {
                                endDate = value.add(Duration(
                                    hours: endDate != null ? endDate.hour : 0,
                                    minutes:
                                        endDate != null ? endDate.minute : 0));
                              });
                            } else if (startDate != null) {
                              setState(() {
                                endDate = startDate;
                              });
                            }
                          });
                          if (endDate != null) {
                            await _selectTime(context).then((value) {
                              if (value != null) {
                                var newDate = endDate.add(Duration(
                                    hours: value.hour - endDate.hour,
                                    minutes: value.minute - endDate.minute));
                                if (startDate != null &&
                                    newDate.isAfter(startDate)) {
                                  setState(() {
                                    endDate = newDate;
                                  });
                                } else if (startDate == null) {
                                  setState(() {
                                    endDate = newDate;
                                  });
                                } else {
                                  endDate = startDate;
                                }
                              }
                            });
                          }
                        },
                        child: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 30),
                Row(
                  children: [
                    Text('To:',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(width: 22),
                    Column(
                      children: [
                        Container(
                          height: 41,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
//                            border: Border.all(
//                                color: Color.fromRGBO(248, 248, 255, 1)),
                          ),
                          child: FlatButton(
                            onPressed: () async {
                              await _endDate(context).then((value) {
                                if (startDate == null ||
                                    (startDate != null &&
                                        value.isAfter(startDate))) {
                                  setState(() {
                                    endDate = value.add(Duration(
                                        hours:
                                            endDate != null ? endDate.hour : 0,
                                        minutes: endDate != null
                                            ? endDate.minute
                                            : 0));
                                  });
                                } else if (startDate != null) {
                                  setState(() {
                                    endDate = startDate;
                                  });
                                }
                              });
                              if (endDate != null) {
                                await _selectTime(context).then((value) {
                                  if (value != null) {
                                    var newDate = endDate.add(Duration(
                                        hours: value.hour - endDate.hour,
                                        minutes:
                                            value.minute - endDate.minute));
                                    if (startDate != null &&
                                        newDate.isAfter(startDate)) {
                                      setState(() {
                                        endDate = newDate;
                                      });
                                    } else if (startDate == null) {
                                      setState(() {
                                        endDate = newDate;
                                      });
                                    } else {
                                      endDate = startDate;
                                    }
                                  }
                                });
                              }
                            },
                            child: Text(
                                endDate != null
                                    ? DateFormat('d MMM y on h:mm a')
                                        .format(endDate)
                                    : 'Select Date & Time',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13,
                                    color: Colors.black)),
                          ),
                        ),
                        endDateError
                            ? Text(
                                "End Time is Required",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.red,
                                    fontSize: 11),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text("Consent From Parents:",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(
                      width: 30,
                    ),
                    DropdownButton(
                      hint: Text(
                        'Select',
                        style: TextStyle(color: Colors.black),
                      ),

                      //dropdownColor: AppColor.background,
                      items: _consentFrom.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              )),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          consentFrom = value;
                        });
                      },
                      value: consentFrom,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  //elevation: 5.0,
                  //color: colour,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: peach,
                  ),
                  //borderRadius: BorderRadius.circular(30.0),
                  child: Builder(
                    builder: (BuildContext context) {
                      return MaterialButton(
                        onPressed: () async {
                          print("hello");
                          if (_formKey.currentState.validate()) {
                            FirebaseFirestore.instance
                                .collection('outPass Form')
                                .add({
                              "destination": destinationController.text,
                              "reason": reasonController.text,
                              "modeOfTransport": modeOfTransport,
                              "consentFrom": consentFrom,
                              "startDate": startDate,
                              "endDate": endDate,
                              "requestDate":requestDate,
                              "approvalStatus":approvalStatus,
                              "studentID": docRef
                            }).then((_) {
                              _displaySnackBar(context);
                              destinationController.clear();
                              reasonController.clear();
                              startDate = null;
                              endDate = null;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        StudentBar()),
                              );
                            }).catchError((onError) {
                              _displayError(context, onError);
                            });
                          }
                        },
                        minWidth: 200.0,
                        height: 50.0,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    reasonController.dispose();
    destinationController.dispose();
  }
}
