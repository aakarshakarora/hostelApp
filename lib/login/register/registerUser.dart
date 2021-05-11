import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login_SignUp page.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Register Hostel in Charge
 */

class HostelUser extends StatefulWidget {
  HostelUser({Key key}) : super(key: key);

  @override
  _HostelUserState createState() => _HostelUserState();
}

class _HostelUserState extends State<HostelUser> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String role;
  bool showSpinner = false;

  final List<String> _roleType = [
    'Mess InCharge',
    'Hostel InCharge',
    'Laundry InCharge'
  ];

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

  /*
  Validation Check Function
   */

  //Send Email Verification Code on Registered Email ID
  Future<void> sendEmailVerification() async {
    User user = await _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  //Check if Field is Empty or not
  // ignore: missing_return
  String checkEmpty(String value) {
    if (value.isEmpty) {
      setState(() {
        showSpinner = false;
      });
      return 'Field Required';
    }
  }

  //Check Email Validation
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

// Password Should be of Atleast 6 Character
  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    } else {
      return null;
    }
  }

  //Check Valid Mobile Number
  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text("Hostel User", style: lightHeading),
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
                  validator: checkEmpty,
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
                        validator: checkEmpty,
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
                        validator: checkEmpty,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text("Role:",
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
                                role = value;
                              });
                            },
                            value: role,
                          ),
                        ],
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
                    if (_registerFormKey.currentState.validate()) {
                      if (pwdInputController.text ==
                          confirmPwdInputController.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: collegeEmailIdHostelInputController.text,
                                password: pwdInputController.text)
                            .then((currentUser) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(currentUser.user.uid)
                              .set({
                            'name': userNameHostelInputController.text
                                .toUpperCase()
                                .toUpperCase(),
                            'role': role,
                            "admin": false,
                          });

                          return FirebaseFirestore.instance
                              .collection("hostel Employee")
                              .doc(currentUser.user.uid)
                              .set({
                                "hostelInChargeID": currentUser.user.uid,
                                "role": role,
                                "collegeEmailIdHostel":
                                    collegeEmailIdHostelInputController.text,
                                "contactNumberHostel":
                                    contactNumberHostelInputController.text,
                                "designationHostel":
                                    designationHostelInputController.text
                                        .toUpperCase(),
                                "userNameHostel": userNameHostelInputController
                                    .text
                                    .toUpperCase(),
                                "personalEmailIdHostel":
                                    personalEmailIdHostelInputController.text,
                                "empIdHostel": empIdHostelController.text,
                                "admin": false,
                              })
                              .then((result) => {
                                    sendEmailVerification(),
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Have a snack!'),
                                      ),
                                    ),
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (_) => false),
                                    collegeEmailIdHostelInputController.clear(),
                                    pwdInputController.clear(),
                                    confirmPwdInputController.clear(),
                                    contactNumberHostelInputController.clear(),
                                    designationHostelInputController.clear(),
                                    userNameHostelInputController.clear(),
                                    personalEmailIdHostelInputController
                                        .clear(),
                                    empIdHostelController.clear(),
                                  })
                              .catchError((err) {
                                print("Test1");
                                print(err);
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text(err.message),
                                  duration: Duration(seconds: 3),
                                ));
                              });
                        }).catchError((err) {
                          print("Test2");
                          print(err);
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(err.message),
                            duration: Duration(seconds: 3),
                          ));
                        });
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
