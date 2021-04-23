import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:intl/intl.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Status: Working Fine [Snack Bar Display Not Working]

/*
OutPass Form from Student Side where registered user can apply for OutPass Request
*/

//Variable on Top and Other Method Below

class OutPassForm extends StatefulWidget {
  @override
  _OutPassFormState createState() => _OutPassFormState();
}

class _OutPassFormState extends State<OutPassForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static String studentID;

  //Check Current User
  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String destination;
  final destinationController = TextEditingController();

  String reason;
  final reasonController = TextEditingController();

  DateTime startDate;
  DateTime endDate;
  DateTime requestDate = DateTime.now();

  bool startDateError = false;
  bool endDateError = false;
  bool read = false;

  String approvalStatus = "Processing";
  String modeOfTransport = "Flight";
  String consentFrom = "Yes";

  String passType = 'OutPass';
  String _groupValue = 'OutPass';
  String inTime = '9';

  String modeOfTransportDP = 'Auto';

  final List<String> _consentFrom = [
    'Yes',
    'No',
  ];

  final List<String> _modeOfTransport = [
    'Flight',
    'Train',
    'Road',
  ];

  final List<String> _modeOfTransportDP = [
    'Bus',
    'Auto',
    'Taxi',
    'Walking',
    'Other',
  ];

  //Enter Destination
  _buildDestinationField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: destinationController,
        textCapitalization: TextCapitalization.sentences,
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

  //Enter Reason
  Widget _buildReasonField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: reasonController,
        textCapitalization: TextCapitalization.sentences,
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
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('student').doc(studentID);
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
                ListTile(
                  leading: Radio(
                    value: 'DayPass',
                    groupValue: _groupValue,
                    toggleable: true,
                    activeColor: peach,
                    onChanged: (newVal) => setState(() {
                      _groupValue = newVal;
                      passType = newVal;
                    }),
                  ),
                  title: Text('Day Pass'),
                  subtitle: Text('If you will be returning same day'),
                ),
                ListTile(
                  leading: Radio(
                    value: 'OutPass',
                    groupValue: _groupValue,
                    toggleable: true,
                    activeColor: peach,
                    onChanged: (newVal) => setState(() {
                      _groupValue = newVal;
                      passType = newVal;
                    }),
                  ),
                  title: Text('Out Pass'),
                  subtitle: Text('If you will be going for a longer period'),
                ),
                _buildReasonField(),
                _buildDestinationField(),
                passType == 'OutPass'
                    ? Row(
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
                      )
                    : Row(
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
                            items: _modeOfTransportDP.map((String value) {
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
                                modeOfTransportDP = value;
                              });
                            },
                            value: modeOfTransportDP,
                          ),
                        ],
                      ),
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
                          if (startDate == null || endDate == null) {
                            setState(() {
                              startDate == null ? startDateError = true : null;
                              endDate == null ? endDateError = true : null;
                            });
                          } else {
                            String collectionName = passType == 'OutPass'
                                ? 'outPass Form'
                                : 'dayPassForm';
                            approvalStatus = passType == 'OutPass'
                                ? 'Processing'
                                : 'Pending';
                            print("hello");
                            print(destination);
                            print(reason);
                            print(destinationController.toString());
                            if (_formKey.currentState.validate()) {
                              FirebaseFirestore.instance
                                  .collection(collectionName)
                                  .add({
                                "destination": destinationController.text,
                                "read": read,
                                "readF": false,
                                "remark": null,
                                "remarkF": null,
                                "reason": reasonController.text,
                                "modeOfTransport": passType == 'OutPass'
                                    ? modeOfTransport
                                    : modeOfTransportDP,
                                "consentFrom": consentFrom,
                                "startDate": startDate,
                                "endDate": endDate,
                                "requestDate": requestDate,
                                "approvalStatus": approvalStatus,
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
                                      builder: (context) => StudentBar()),
                                );
                              }).catchError((onError) {
                                _displayError(context, onError);
                              });
                            }
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

  //Select Start Date
  Future<DateTime> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
      lastDate: passType == 'OutPass'
          ? endDate ?? DateTime(2100)
          : DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: peach,
              onPrimary: white,
              surface: peach,
              onSurface: white,
            ),
            dialogBackgroundColor: darkerBlue,
          ),
          child: child,
        );
      },
    );
    return picked.toLocal();
  }

  //Select Start Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(
        DateTime.utc(0),
      ),
      context: context,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: darkerBlue,
              onPrimary: white,
              surface: peach,
              onSurface: darkerBlue,
            ),
          ),
          child: child,
        );
      },
    );
    return selectedTime;
  }

  //Select End Date
  Future<DateTime> _endDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: passType == 'OutPass'
          ? startDate ?? DateTime.now().toLocal()
          : DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
      firstDate: passType == 'OutPass'
          ? startDate ?? DateTime.now().toLocal()
          : DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
      lastDate: passType == 'OutPass'
          ? DateTime(2100)
          : DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 1),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: peach,
              onPrimary: white,
              surface: peach,
              onSurface: white,
            ),
            dialogBackgroundColor: darkerBlue,
          ),
          child: child,
        );
      },
    );
    return picked.toLocal();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentID = getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    reasonController.dispose();
    destinationController.dispose();
  }
}
