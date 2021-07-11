import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../theme/theme.dart';

class FUpdateForm extends StatefulWidget {
  final dynamic eUid;
  final dynamic eName;
  final dynamic eDesignation;
  final String eRole;
  final dynamic eID;
  final dynamic ePhone;
  final dynamic eEmail;
  final bool admin;

  FUpdateForm(
      {this.eUid,
      this.eName,
      this.eDesignation,
      this.eRole,
      this.eID,
      this.ePhone,
      this.eEmail,
      this.admin});

  @override
  _SUpdateFormState createState() => _SUpdateFormState();
}

class _SUpdateFormState extends State<FUpdateForm> {
  final List<String> _roleType = [
    'Mess InCharge',
    'Hostel InCharge',
    'Laundry InCharge',
    'Security InCharge'
  ];
  TextEditingController eName, eDesignation, eID, ePhone, eEmail;
  String eRole;
  bool adminCheck;

  @override
  void initState() {
    eName = TextEditingController()..text = widget.eName;
    eDesignation = TextEditingController()..text = widget.eDesignation;
    eID = TextEditingController()..text = widget.eID;
    ePhone = TextEditingController()..text = widget.ePhone;
    eEmail = TextEditingController()..text = widget.eEmail;
    adminCheck = widget.admin;
    eRole = widget.eRole;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text("Info of: " + widget.eName, style: lightHeading),
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
                  labelText: 'Employee Name: ',
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
                controller: eName,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Email ID: ',
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
                controller: eEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number: ',
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
                controller: ePhone,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              height: 8,
            ),
            Text("Employee Details"),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Role: "),
                SizedBox(
                  width: 15,
                ),
                DropdownButton(
                  hint: Text(
                    'Select',
                    style: TextStyle(color: Colors.black),
                  ),
                  items: _roleType.map((String value) {
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
                      eRole = value;
                    });
                  },
                  value: eRole,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Employee ID: ',
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
                controller: eID,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Employee Designation: ',
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
                controller: eDesignation,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Admin Check: "),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Yes",
                ),
                Radio<bool>(
                    groupValue: adminCheck,
                    value: true,
                    onChanged: (v) {
                      setState(() {
                        adminCheck = v;
                      });
                    }),
                Text(
                  "No",
                ),
                Radio<bool>(
                    groupValue: adminCheck,
                    value: false,
                    onChanged: (v) {
                      setState(() {
                        adminCheck = v;
                      });
                    }),
              ],
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
                  print(widget.eUid);
                  FirebaseFirestore.instance
                      .collection('hostel Employee')
                      .doc(widget.eUid)
                      .update({
                    "userNameHostel": eName.text.toUpperCase(),
                    "personalEmailIdHostel": eEmail.text,
                    "contactNumberHostel": ePhone.text,
                    "role": eRole,
                    "designationHostel": eDesignation.text,
                    "empIdHostel": eID.text,
                    "admin": adminCheck,
                  });
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.eUid)
                      .update({
                    "userNameHostel": eName.text.toUpperCase(),
                    "admin": adminCheck,
                    "role": eRole,
                  });

                  final snackBar = SnackBar(
                    content: Container(
                      height: 50,
                      child: Text(eName.text + ' Info Updated !!',
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
