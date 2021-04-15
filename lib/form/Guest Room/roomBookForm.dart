import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:intl/intl.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Status: Working Fine [Snack Bar Display Not Working]

/*
Guest Room Book Form from Student Side where registered user can apply for Room Book Request
*/

//Variable on Top and Other Method Below

// ignore: must_be_immutable
class RoomBook extends StatefulWidget {
  static String studentID;
  String roomType;

  @override
  _RoomBookState createState() => _RoomBookState();

  RoomBook(this.roomType);
}

class _RoomBookState extends State<RoomBook> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Check Current User
  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  String roomStatus = "Pending";
  String getFare;

  String guestName;
  final guestNameController = TextEditingController();

  String purpose;
  final purposeController = TextEditingController();

  String guestRelation;
  final guestRelationController = TextEditingController();

  String guestAddress;
  final guestAddressController = TextEditingController();

  final guestCountController = TextEditingController();
  String roomCount;

  final roomCountController = TextEditingController();
  final dayCountController = TextEditingController();

  int guestCount = 1;
  int dayCount = 1;

  num roomFare = 0;
  num rooms = 0;

  DateTime startDate;
  DateTime endDate;
  DateTime requestDate = DateTime.now();

  bool startDateError = false;
  bool endDateError = false;
  bool read = false;

  //Select Start Date
  Future<DateTime> _startDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().toLocal(),
      firstDate: DateTime.now().toLocal(),
      lastDate: endDate ?? DateTime(2100),
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

  //Select Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(DateTime.utc(0)),
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

//Enter Guest Name
  Widget _guestName() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: guestNameController,
        decoration:
            kTextFieldDecoration.copyWith(labelText: 'Enter Guest Name: '),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Field is required';
          }
        },
        onSaved: (String value) {
          guestName = value;
          print(guestName);
        },
      ),
    );
  }

  //Enter Purpose
  Widget _purpose() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        controller: purposeController,
        decoration:
            kTextFieldDecoration.copyWith(labelText: 'Purpose of Visit '),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Field is required';
          }
        },
        onSaved: (String value) {
          purpose = value;
        },
      ),
    );
  }

  //Enter Guest Relation
  Widget _guestRelation() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        controller: guestRelationController,
        decoration:
            kTextFieldDecoration.copyWith(labelText: 'Guest Relation: '),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Field is required';
          }
        },
        onSaved: (String value) {
          guestRelation = value;
        },
      ),
    );
  }

  //Enter Guest Address
  Widget _guestAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLines: 3,
        minLines: 1,
        textCapitalization: TextCapitalization.words,
        controller: guestAddressController,
        decoration: kTextFieldDecoration.copyWith(labelText: 'Guest Address: '),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Field is required';
          }
        },
        onSaved: (String value) {
          guestAddress = value;
        },
      ),
    );
  }

  //Select Date and Time
  Widget _selectDate() {
    return Row(
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
                borderRadius: BorderRadius.all(Radius.circular(12)),
//                                border: Border.all(
//                                    color: Color.fromRGBO(248, 248, 255, 1)),
              ),
              child: FlatButton(
                onPressed: () async {
                  await _startDate(context).then((value) {
                    if (endDate == null ||
                        (endDate != null && value.isBefore(endDate))) {
                      setState(() {
                        startDate = value.add(Duration(
                            hours: startDate != null ? startDate.hour : 0,
                            minutes: startDate != null ? startDate.minute : 0));
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
                            minutes: value.minute - startDate.minute));
                        if (endDate != null && newDate.isBefore(endDate)) {
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
                        ? DateFormat('d MMM y on h:mm a').format(startDate)
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
                        fontFamily: 'Poppins', color: Colors.red, fontSize: 11),
                  )
                : Container(),
          ],
        ),
      ],
    );
  }

  //Guest Count Slider
  Widget _guestCountSlider() {
    return Row(
      children: [
        Text("Guest Count: ",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        Container(
          width: 150,
          child: Slider(
              min: 1,
              max: 20,
              activeColor: peach,
              inactiveColor: Colors.grey,
              divisions: 20,
              value: guestCount.toDouble(),
              onChanged: (double value) {
                setState(() {
                  guestCount = value.round();
                  _formKey.currentState.save();
                  print("test");
                  getFare =
                      calculateRoomFare(widget.roomType, guestCount, dayCount);

                  roomCount = roomRequest(guestCount);
                  print("test2");
                  print(roomCount);

                  print(getFare);
                });
              }),
        ),
        Text(guestCount.toString(),
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
      ],
    );
  }

  //Day Count Button
  Widget _dayCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text("Day Count: ",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        SizedBox(
          width: 5,
        ),
        FlatButton(
          shape: CircleBorder(), color: peach,
          onPressed: minus,
          child: new Icon(
            Icons.remove,
            color: Colors.black,
          ),
          //backgroundColor: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        new Text(
          '$dayCount',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'PoppinsBold'),
        ),
        SizedBox(
          width: 5,
        ),
        FlatButton(
          shape: CircleBorder(), color: peach,
          onPressed: add,
          child: new Icon(
            Icons.add,
            color: Colors.black,
          ),
          // backgroundColor: Colors.white,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('student')
        .doc(RoomBook.studentID);
    setState(() {
      print(docRef.toString());
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        centerTitle: true,
        title: Text(
          'Room Booking',
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
                _guestName(),
                _guestRelation(),
                _purpose(),
                _guestAddress(),
                _selectDate(),
                _dayCount(),
                _guestCountSlider(),

                Row(
                  children: [
                    Text("Room Type:",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    SizedBox(
                      width: 20,
                    ),
                    Text(widget.roomType,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ],
                ),
                //SizedBox(width: 30),

                SizedBox(
                  height: 20,
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("₹ "),
                        Text(getFare ?? "0.0",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        SizedBox(
                          width: 25,
                        ),
                        Text("Room Allotment : "),
                        Text(roomCount ?? "0",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                //Submit Button

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
                          _formKey.currentState.save();

                          if (startDate == null) {
                            setState(() {
                              // ignore: unnecessary_statements
                              startDate == null ? startDateError = true : null;
                            });
                          } else {
                            if (_formKey.currentState.validate()) {
                              FirebaseFirestore.instance
                                  .collection('roomBook')
                                  .add({
                                "read": read,
                                "guestName": guestNameController.text,
                                "purpose": purposeController.text,
                                "guestRelation": guestRelationController.text,
                                "guestAddress": guestAddressController.text,
                                "startDate": startDate,
                                "guestCount": guestCount,
                                "dayCount": dayCount,
                                "roomStatus": roomStatus,
                                "requestDate": requestDate,
                                "roomType": widget.roomType,
                                "roomFare": roomFare.toString(),
                                "roomRequest": rooms.toString(),
                                "studentID": docRef
                              }).then((_) {
                                _displaySnackBar(context);
                                guestNameController.clear();
                                purposeController.clear();
                                guestRelationController.clear();
                                guestAddressController.clear();
                                guestCountController.clear();
                                dayCountController.clear();
                                startDate = null;
                                endDate = null;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StudentBar()),
                                );
                              }).catchError((onError) {
                                print(onError);
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

  //Calculate Room Fare
  String calculateRoomFare(String type, int guestCount, int dayCount) {
    print('inside calculateroomfare');
    print('type $type guestcount $guestCount daycount $dayCount');
    if (widget.roomType == "EXECUTIVE" || widget.roomType == "Executive") {
      roomFare = 1600;
      if (guestCount == 0 || guestCount == 1 || guestCount == 2) {
        roomFare = roomFare * dayCount;
      } else {
        roomFare = ((guestCount / 2).ceil()) * roomFare * dayCount;
      }
    } else if (widget.roomType == "STANDARD" || widget.roomType == "Standard") {
      roomFare = 1200;
      if (guestCount == 0 || guestCount == 1 || guestCount == 2) {
        roomFare = roomFare * dayCount;
      } else {
        roomFare = ((guestCount / 2).ceil()) * roomFare * dayCount;
      }
    } else if (widget.roomType == "STUDENT" || widget.roomType == "Student") {
      roomFare = 920;
      if (guestCount == 0 || guestCount == 1 || guestCount == 2) {
        roomFare = roomFare * dayCount;
      } else {
        roomFare = ((guestCount / 2).ceil()) * roomFare * dayCount;
      }
    }
    print('roomfare $roomFare');
    return roomFare.toString();
  }

  //Calculate Room Request
  String roomRequest(int guest) {
    rooms = (guest / 2).ceil();
    return rooms.toString();
  }

//Add Guest Count
  void add() {
    setState(() {
      dayCount++;
      _formKey.currentState.save();
      print("Room Add");
      getFare = calculateRoomFare(widget.roomType, guestCount, dayCount);
      roomCount = roomRequest(guestCount);
      print("Room Count and Fare");
      print(roomCount);
      print(getFare);
    });
  }

//Subtract Guest Count
  void minus() {
    setState(() {
      if (dayCount != 1) dayCount--;
      _formKey.currentState.save();
      print("Room Subtract");
      getFare = calculateRoomFare(widget.roomType, guestCount, dayCount);
      roomCount = roomRequest(guestCount);
      print("Room Count and Fare");
      print(roomCount);
      print(getFare);
    });
  }

//Display Snack Bar
  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
      'Request Sent Successfully',
      style: TextStyle(fontFamily: 'Poppins'),
    ));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    RoomBook.studentID = getCurrentUser();
    print("Calculate Room Fare");
    getFare = calculateRoomFare(widget.roomType, guestCount, dayCount);
    print(getFare);
    roomCount = roomRequest(guestCount);
    print("Calculate Room Count");
    print(roomCount);
    print(getFare);
  }

  @override
  void dispose() {
    super.dispose();
    guestNameController.dispose();
    purposeController.dispose();
    guestRelationController.dispose();
    guestAddressController.dispose();
    guestCountController.dispose();
    dayCountController.dispose();
  }
}
