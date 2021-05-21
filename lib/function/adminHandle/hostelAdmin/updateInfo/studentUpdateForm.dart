import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class SUpdateForm extends StatefulWidget {
  final dynamic sUid;
  final dynamic sName;
  final dynamic sCourse;
  final dynamic sRegNo;
  final dynamic pName;
  final dynamic pPhone;
  final dynamic pEmail;
  final String roomBlock;
  final String roomType;
  final dynamic roomNo;

  SUpdateForm(
      {this.sUid,
      this.sName,
      this.sCourse,
      this.sRegNo,
      this.pName,
      this.pPhone,
      this.pEmail,
      this.roomBlock,
      this.roomType,
      this.roomNo});

  @override
  _SUpdateFormState createState() => _SUpdateFormState();
}

class _SUpdateFormState extends State<SUpdateForm> {
  final List<String> _occupancyType = [
    'Single',
    'Single Premium',
    'Double',
  ];

  final List<String> _block = [
    'B1',
    'B2',
    'B3',
    'B4',
    'B5',
    'B6',
    'B7',
    'G1',
    'G2',
    'G3',
    'G4',
  ];
  TextEditingController sName, sCourse, sRegNo, pName, pPhone, pEmail, roomNo;
  String roomBlock, roomType;

  @override
  void initState() {
    sName = TextEditingController()..text = widget.sName;
    sCourse = TextEditingController()..text = widget.sCourse;
    sRegNo = TextEditingController()..text = widget.sRegNo;
    pName = TextEditingController()..text = widget.pName;
    pPhone = TextEditingController()..text = widget.pPhone;
    pEmail = TextEditingController()..text = widget.pEmail;
    roomNo = TextEditingController()..text = widget.roomNo;
    roomType = widget.roomType;
    roomBlock = widget.roomBlock;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text("Info of: " + widget.sName, style: lightHeading),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Text("User Details"),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Student Name: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: sName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Course Name: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: sCourse,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Registration Number: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: sRegNo,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              height: 3,
            ),
            Text("Hostel Room Details"),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Occupancy Type:"),
                SizedBox(
                  width: 15,
                ),
                DropdownButton(
                  hint: Text(
                    'Select',
                    style: TextStyle(color: Colors.black),
                  ),

                  //dropdownColor: AppColor.background,
                  items: _occupancyType.map((String value) {
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
                      roomType = value;
                    });
                  },
                  value: roomType,
                ),
                Text("Block: "),
                SizedBox(
                  width: 15,
                ),
                DropdownButton(
                  hint: Text(
                    'Select',
                    style: TextStyle(color: Colors.black),
                  ),
                  items: _block.map((String value) {
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
                      roomBlock = value;
                    });
                  },
                  value: roomBlock,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Room number: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: roomNo,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              height: 3,
            ),
            Text("Parent Detail"),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Parent Name: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: pName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Parent Contact Number: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: pPhone,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Parent Email: ',
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Poppins'),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900], width: 2.5),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
                controller: pEmail,
              ),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("Update"),
                color: peach,
                textColor: Colors.white,
                onPressed: () {
                  print(widget.sUid);
                  FirebaseFirestore.instance
                      .collection('student')
                      .doc(widget.sUid)
                      .update({
                    "studentName": sName.text.toUpperCase(),
                    "courseName": sCourse.text,
                    "registrationNumber": sRegNo.text,
                    "occupancyType": roomType,
                    "block": roomBlock,
                    "roomNumber": roomNo.text,
                    "parentName": pName.text,
                    "parentContactNumber": pPhone.text,
                    "parentEmailID": pEmail.text,
                  });
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.sUid)
                      .update({
                    "studentName": sName.text.toUpperCase(),
                  });

                  final snackBar = SnackBar(
                    content: Container(
                      height: 50,
                      child: Text(sName.text + ' Info Updated !!',
                          style: lightSmallText.copyWith(
                              fontWeight: FontWeight.bold)),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
