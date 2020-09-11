import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/theme/theme.dart';

class ListItem {
  int value;
  Text name;

  ListItem(this.value, this.name);
}

class StudentRegister extends StatefulWidget {
  StudentRegister({Key key}) : super(key: key);

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String role = "Student";

  bool _obscureText1 = true;
  bool _obscureText2 = true;

  List<ListItem> _dropDownBlock = [
    ListItem(1, Text('Not Selected', style: darkTinyText)),
    ListItem(2, Text('G1', style: darkTinyText)),
    ListItem(3, Text('G2', style: darkTinyText)),
    ListItem(4, Text('G3', style: darkTinyText)),
    ListItem(5, Text('G4', style: darkTinyText)),
    ListItem(6, Text('B1', style: darkTinyText)),
    ListItem(7, Text('B2', style: darkTinyText)),
    ListItem(8, Text('B3', style: darkTinyText)),
    ListItem(9, Text('B4', style: darkTinyText)),
    ListItem(10, Text('B5', style: darkTinyText)),
    ListItem(11, Text('B6', style: darkTinyText)),
    ListItem(12, Text('B7', style: darkTinyText)),
  ];

  List<ListItem> _dropDownOccupancy = [
    ListItem(1, Text('Not Selected', style: darkTinyText)),
    ListItem(2, Text('Single', style: darkTinyText)),
    ListItem(3, Text('Single Premium', style: darkTinyText)),
    ListItem(4, Text('Double', style: darkTinyText)),
  ];

  List<DropdownMenuItem<ListItem>> _dropDownMenuBlock;
  ListItem _selectedBlock;

  List<DropdownMenuItem<ListItem>> _dropDownMenuOccupancy;
  ListItem _selectedOccupancy;

  @override
  initState() {
    super.initState();
    _dropDownMenuBlock = buildDropDownMenuItems(_dropDownBlock);
    _selectedBlock = _dropDownMenuBlock[0].value;
    _dropDownMenuOccupancy = buildDropDownMenuItems(_dropDownOccupancy);
    _selectedOccupancy = _dropDownMenuOccupancy[0].value;
    //  pwdInputController = new TextEditingController();
    //  confirmPwdInputController = new TextEditingController();
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: listItem.name,
          value: listItem,
        ),
      );
    }
    return items;
  }

  TextEditingController studentEmailIDInputController =
      new TextEditingController();
  TextEditingController pwdInputController = new TextEditingController();
  TextEditingController confirmPwdInputController = new TextEditingController();
  TextEditingController parentNameInputController = new TextEditingController();

  TextEditingController batchInputController = new TextEditingController();
  TextEditingController blockInputController = new TextEditingController();
  TextEditingController collegeEmailIDInputController =
      new TextEditingController();
  TextEditingController courseNameInputController = new TextEditingController();
  TextEditingController mentorEmailIDInputController =
      new TextEditingController();
  TextEditingController mentorContactNumberInputController =
      new TextEditingController();
  TextEditingController mentorNameInputController = new TextEditingController();
  TextEditingController occupancyTypeInputController =
      new TextEditingController();
  TextEditingController parentContactNumberInputController =
      new TextEditingController();
  TextEditingController parentEmailIDInputController =
      new TextEditingController();
  TextEditingController registrationNumberInputController =
      new TextEditingController();
  TextEditingController roomNumberInputController = new TextEditingController();
  TextEditingController studentContactNumberInputController =
      new TextEditingController();
  TextEditingController studentNameInputController =
      new TextEditingController();
  TextEditingController block = new TextEditingController();
  TextEditingController occupancyType = new TextEditingController();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    return null;
  }

//  String batchValidator(String value) {
//    Pattern pattern =
//        r'^(([0-9]+(0-9)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//    RegExp regex = new RegExp(pattern);
//
//    {
//      if (!regex.hasMatch(value)) {
//        return 'Enter Valid Batch eg: 2018-22';
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text("Register as Student", style: lightHeading),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Student Name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  controller: studentNameInputController,
                  // ignore: missing_return
                  validator: (value) {},
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Student Email ID',
                  ),
                  controller: studentEmailIDInputController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        color: peach,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                  ),
                  controller: pwdInputController,
                  obscureText: _obscureText1,
                  validator: pwdValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText2 ? Icons.visibility_off : Icons.visibility,
                        color: peach,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                  ),
                  controller: confirmPwdInputController,
                  obscureText: _obscureText2,
                  validator: pwdValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Student Details", style: darkHeading),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'College Email ID:',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: collegeEmailIDInputController,
                          // ignore: missing_return
                          validator: emailValidator),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Student Contact Number:',
                        ),
                        keyboardType: TextInputType.phone,
                        controller: studentContactNumberInputController,
                        validator: validateMobile,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Registration Number:',
                        ),
                        keyboardType: TextInputType.number,
                        controller: registrationNumberInputController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Course Name:',
                        ),
                        controller: courseNameInputController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Batch:',
                        ),
                        controller: batchInputController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Occupancy Type :',
                                style:
                                    darkHeading.copyWith(color: Colors.grey)),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<ListItem>(
                                value: _selectedOccupancy,
                                items: _dropDownMenuOccupancy,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedOccupancy = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Block :',
                                style:
                                    darkHeading.copyWith(color: Colors.grey)),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<ListItem>(
                                value: _selectedBlock,
                                items: _dropDownMenuBlock,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedBlock = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Room Number:',
                        ),
                        keyboardType: TextInputType.number,
                        controller: roomNumberInputController,
                      ),

                      SizedBox(
                        height: 18,
                      ),

//                    Drop Down Button issue there need to solved later
//                        Row(
//                          children: [
//                            Text("Block:",
//                                style: TextStyle(
//                                    fontFamily: 'Poppins',
//                                    fontSize: 17,
//                                    fontWeight: FontWeight.w500,
//                                    color: Colors.black)),
//                            SizedBox(
//                              width: 20,
//                            ),
//                            DropdownButton(
//                              hint: Text(
//                                'Select',
//                                style: TextStyle(color: Colors.black),
//                              ),
//
//                              //dropdownColor: AppColor.background,
//                              items: _block.map((String value) {
//                                return DropdownMenuItem<String>(
//                                  value: value,
//
//                                  child: Text(value,
//                                      style: TextStyle(
//                                        fontFamily: 'Poppins',
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.black,
//                                      )),
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//                                setState(() {
//                                  block = value;
//                                });
//                              },
//                              value: block,
//
//                            ),
//                          ],
//                        ),
//                        Row(
//                          children: [
//                            Text("OccupancyType:",
//                                style: TextStyle(
//                                    fontFamily: 'Poppins',
//                                    fontSize: 17,
//                                    fontWeight: FontWeight.w500,
//                                    color: Colors.black)),
//                            SizedBox(
//                              width: 20,
//                            ),
//                            DropdownButton(
//                              hint: Text(
//                                'Select',
//                                style: TextStyle(color: Colors.black),
//                              ),
//
//                              //dropdownColor: AppColor.background,
//                              items: _occupancyType.map((String value) {
//                                return DropdownMenuItem<String>(
//                                  value: value,
//
//                                  child: Text(value,
//                                      style: TextStyle(
//                                        fontFamily: 'Poppins',
//                                        fontSize: 14,
//                                        fontWeight: FontWeight.bold,
//                                        color: Colors.black,
//                                      )),
//                                );
//                              }).toList(),
//                              onChanged: (value) {
//                                setState(() {
//                                  occupancyType = value;
//                                });
//                              },
//                              value: occupancyType,
//
//                            ),
//                          ],
//                        ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Parent Details",
                        style: darkHeading,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Parent Name:',
                        ),
                        controller: parentNameInputController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Parent Email ID:',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: parentEmailIDInputController,
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Parent Contact Number:',
                        ),
                        controller: parentContactNumberInputController,
                        validator: validateMobile,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Mentor Details",
                        style: darkHeading,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Mentor Name:',
                        ),
                        textCapitalization: TextCapitalization.words,
                        controller: mentorNameInputController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Mentor Email ID:',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: mentorEmailIDInputController,
                        validator: emailValidator,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Mentor Contact Number:',
                        ),
                        keyboardType: TextInputType.phone,
                        controller: mentorContactNumberInputController,
                        validator: validateMobile,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Register"),
                  color: peach,
                  textColor: Colors.white,
                  onPressed: () {
//                      print(  studentEmailIDInputController.text);
//                      print(  pwdInputController.text);
//                      print(  confirmPwdInputController.text);
//                      print(  parentNameInputController.text);
//
//
//                      print(  batchInputController.text);
//                      print(  blockInputController.text);
//                      print(  collegeEmailIDInputController.text);
//                      print(  courseNameInputController.text);
//                      print(  mentorEmailIDInputController.text);
//                      print(  mentorContactNumberInputController.text);
//                      print(  mentorNameInputController.text);
//                      print(  occupancyTypeInputController.text.toUpperCase());
//                      print(  parentContactNumberInputController.text);
//                      print(  parentEmailIDInputController.text);
//                      print(  registrationNumberInputController.text);
//                      print(  roomNumberInputController.text);
//                      print(  studentContactNumberInputController.text);
//                      print(  studentNameInputController.text);
                    if (_registerFormKey.currentState.validate()) {
                      if (pwdInputController.text ==
                          confirmPwdInputController.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: studentEmailIDInputController.text,
                                password: pwdInputController.text)
                            .then((currentUser) => FirebaseFirestore.instance
                                .collection("student")
                                .doc(currentUser.user.uid)
                                .set({
                                  "studentID": currentUser.user.uid,
                                  "batch": batchInputController.text,
                                  "block": blockInputController.text,
                                  "collegeEmailID":
                                      collegeEmailIDInputController.text,
                                  "courseName": courseNameInputController.text
                                      .toUpperCase(),
                                  "mentorName": mentorNameInputController.text,
                                  "mentorContactNumber":
                                      mentorContactNumberInputController.text,
                                  "mentorEmailId":
                                      mentorEmailIDInputController.text,
                                  "occupancyType": occupancyType.text,
                                  "parentContactNumber":
                                      parentContactNumberInputController.text,
                                  "parentEmailID":
                                      parentEmailIDInputController.text,
                                  "parentName": parentNameInputController.text,
                                  "registrationNumber":
                                      registrationNumberInputController.text,
                                  "role": role.toString(),
                                  "roomNumber": roomNumberInputController.text,
                                  "studentContactNumber":
                                      studentContactNumberInputController.text,
                                  "studentEmailID":
                                      studentEmailIDInputController.text,
                                  "studentName":
                                      studentNameInputController.text,
                                })
                                .then((result) => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentBar()),
                                          (_) => false),
                                      studentEmailIDInputController.clear(),
                                      pwdInputController.clear(),
                                      confirmPwdInputController.clear(),
                                      batchInputController.clear(),
                                      blockInputController.clear(),
                                      collegeEmailIDInputController.clear(),
                                      courseNameInputController.clear(),
                                      mentorEmailIDInputController.clear(),
                                      mentorContactNumberInputController
                                          .clear(),
                                      mentorNameInputController.clear(),
                                      occupancyTypeInputController.clear(),
                                      parentContactNumberInputController
                                          .clear(),
                                      parentEmailIDInputController.clear(),
                                      registrationNumberInputController.clear(),
                                      roomNumberInputController.clear(),
                                      studentContactNumberInputController
                                          .clear(),
                                      studentNameInputController.clear(),
                                      parentNameInputController.clear(),
                                    })
                                .catchError((err) => print(err)))
                            .catchError((err) => print(err));
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("The passwords do not match"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  "Already have an account?",
                  style: darkSmallText,
                ),
                FlatButton(
                  child: Text(
                    "Login here!",
                    style: darkSmallTextBold,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
