import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/theme/theme.dart';

import '../common/bottomBar/navigationBarHostel.dart';

class HostelRegister extends StatefulWidget {
  HostelRegister({Key key}) : super(key: key);

  @override
  _HostelRegisterState createState() => _HostelRegisterState();
}

class _HostelRegisterState extends State<HostelRegister> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String role = "Hostel InCharge";
  TextEditingController collegeEmailIdHostelInputController =
      new TextEditingController();
  TextEditingController pwdInputController = new TextEditingController();
  TextEditingController confirmPwdInputController = new TextEditingController();

  TextEditingController contactNumberHostelInputController =
      new TextEditingController();
  TextEditingController empIdHostelController = new TextEditingController();
  TextEditingController designationHostelInputController =
      new TextEditingController();
  TextEditingController userNameHostelInputController =
      new TextEditingController();
  TextEditingController personalEmailIdHostelInputController =
      new TextEditingController();

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
        title: Text("Register as Warden", style: lightHeading),
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
                    labelText: 'Name',
                  ),
                  textCapitalization: TextCapitalization.words,
                  controller: userNameHostelInputController,
                  // ignore: missing_return
                  validator: (value) {},
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    helperText: "For App Registration",
                    labelText: 'User Email ID',
                  ),
                  controller: collegeEmailIdHostelInputController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Password',
                  ),
                  controller: pwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                    labelText: 'Confirm Password',
                  ),
                  controller: confirmPwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "User Details",
                        style: darkHeading,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Personal Email ID:',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: personalEmailIdHostelInputController,
                          // ignore: missing_return
                          validator: emailValidator),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'User Contact Number:',
                        ),
                        keyboardType: TextInputType.phone,
                        controller: contactNumberHostelInputController,
                        validator: validateMobile,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Employee ID:',
                        ),
                        controller: empIdHostelController,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Designation:',
                        ),
                        textCapitalization: TextCapitalization.words,
                        controller: designationHostelInputController,
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
                                email: collegeEmailIdHostelInputController.text,
                                password: pwdInputController.text)
                            .then((currentUser) => FirebaseFirestore.instance
                                .collection("hostelInCharge")
                                .doc(currentUser.user.uid)
                                .set({
                                  "hostelInChargeID": currentUser.user.uid,
                                  "role": role,
                                  "collegeEmailIdHostel":
                                      collegeEmailIdHostelInputController.text,
                                  "contactNumberHostel":
                                      contactNumberHostelInputController.text,
                                  "designationHostel":
                                      designationHostelInputController.text,
                                  "userNameHostel":
                                      userNameHostelInputController.text,
                                  "personalEmailIdHostel":
                                      personalEmailIdHostelInputController.text,
                                  "empIdHostel": empIdHostelController.text,
                                })
                                .then((result) => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HostelBar()),
                                          (_) => false),
                                      collegeEmailIdHostelInputController
                                          .clear(),
                                      pwdInputController.clear(),
                                      confirmPwdInputController.clear(),
                                      contactNumberHostelInputController
                                          .clear(),
                                      designationHostelInputController.clear(),
                                      userNameHostelInputController.clear(),
                                      personalEmailIdHostelInputController
                                          .clear(),
                                      empIdHostelController.clear(),
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
