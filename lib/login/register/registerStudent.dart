import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/theme/theme.dart';
import '../login_SignUp page.dart';

//Status: Working Fine

/*
Register Student
 */

class StudentRegister extends StatefulWidget {
  StudentRegister({Key key}) : super(key: key);

  @override
  _StudentRegisterState createState() => _StudentRegisterState();
}

class _StudentRegisterState extends State<StudentRegister> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String occupancyType;
  String block, cyclePlan;
  String role = "Student";
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool showSpinner = false;

  // String laundryStatus = 'Active';
  // int cycles = 0;
  // String fare;

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

  // var _cyclePlan = ['30 Cycles', '15 Cycles'];
  //
  // String getFare(String type) {
  //   String fare;
  //   if (type == '30 Cycles') {
  //     fare = '7500';
  //     return fare;
  //   } else if (type == '15 Cycles') {
  //     fare = '4200';
  //     return fare;
  //   } else
  //     return null;
  // }
  //
  // int getCycle(String type) {
  //   if (type == '30 Cycles') {
  //     return 30;
  //   } else if (type == '15 Cycles') {
  //     return 15;
  //   } else
  //     return 0;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cycles = getCycle(cyclePlan);
    // fare = getFare(cyclePlan);
  }

  TextEditingController studentEmailIDInputController =
      new TextEditingController();

  TextEditingController pwdInputController = new TextEditingController();

  TextEditingController confirmPwdInputController = new TextEditingController();

  TextEditingController parentNameInputController = new TextEditingController();

  TextEditingController batchInputController = new TextEditingController();

  TextEditingController collegeEmailIDInputController =
      new TextEditingController();

  TextEditingController courseNameInputController = new TextEditingController();

  TextEditingController mentorEmailIDInputController =
      new TextEditingController();

  TextEditingController mentorContactNumberInputController =
      new TextEditingController();

  TextEditingController mentorNameInputController = new TextEditingController();

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

  //Check Valid Batch Entered by Student
  // ignore: missing_return
  String batchValidator(String value) {
    if (value.isNotEmpty) {
      if (value.length != 4) {
        return 'Enter Valid Year';
      }
//       return "Valid Year Entered";
    } else {
      return 'Field is Required';
    }
  }

  // Widget _buildCycleType() {
  //   return Container(
  //     child: Row(
  //       children: [
  //         Text("Select Plan Type:",
  //             style: TextStyle(
  //                 fontFamily: 'Poppins',
  //                 fontSize: 17,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.black)),
  //         SizedBox(
  //           width: 30,
  //         ),
  //         DropdownButton<String>(
  //           hint: Text(
  //             'Select',
  //             style: TextStyle(color: Colors.black),
  //           ),
  //           items: _cyclePlan.map((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(value,
  //                   style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.black,
  //                   )),
  //             );
  //           }).toList(),
  //           onChanged: (String value) {
  //             setState(() {
  //               this.cyclePlan = value;
  //               cycles = getCycle(cyclePlan);
  //               fare = getFare(cyclePlan);
  //             });
  //           },
  //           value: cyclePlan,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        backgroundColor: darkerBlue,
        title: Text("Student", style: lightHeading),
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
                    validator: checkEmpty),
                SizedBox(
                  height: 18,
                ),
                TextFormField(
                  decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Student Email ID',
                      helperText: "For App Registration and Verification"),
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

                //Student Personal Details
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
                        validator: checkEmpty,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Course Name:',
                        ),
                        controller: courseNameInputController,
                        validator: checkEmpty,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Batch:',
                          hintText: "2018",
                          helperText: "Enter Last Year of Your Program ",
                        ),
                        controller: batchInputController,
                        validator: checkEmpty,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: 18,
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
                        validator: checkEmpty,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text("Occupancy Type:",
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
                                occupancyType = value;
                              });
                            },
                            value: occupancyType,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: [
                          Text("Block:",
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
                                block = value;
                              });
                            },
                            value: block,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Parent Details

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
                        validator: checkEmpty,
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

                //Mentor Details
                // Container(
                //   child: Column(
                //     children: [
                //       Text(
                //         "Mentor Details",
                //         style: darkHeading,
                //       ),
                //       SizedBox(
                //         height: 18,
                //       ),
                //       TextFormField(
                //         decoration: kTextFieldDecoration.copyWith(
                //           labelText: 'Mentor Name:',
                //         ),
                //         textCapitalization: TextCapitalization.words,
                //         controller: mentorNameInputController,
                //         validator: checkEmpty,
                //       ),
                //       SizedBox(
                //         height: 18,
                //       ),
                //       TextFormField(
                //         decoration: kTextFieldDecoration.copyWith(
                //           labelText: 'Mentor Email ID:',
                //         ),
                //         keyboardType: TextInputType.emailAddress,
                //         controller: mentorEmailIDInputController,
                //         validator: emailValidator,
                //       ),
                //       SizedBox(
                //         height: 18,
                //       ),
                //       TextFormField(
                //         decoration: kTextFieldDecoration.copyWith(
                //           labelText: 'Mentor Contact Number:',
                //         ),
                //         keyboardType: TextInputType.phone,
                //         controller: mentorContactNumberInputController,
                //         validator: validateMobile,
                //       ),
                //       SizedBox(
                //         height: 18,
                //       ),
                //     ],
                //   ),
                // ),

                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Register"),
                  color: peach,
                  textColor: Colors.white,
                  onPressed: () {
                    print(occupancyType);
                    print(block);
                    if (_registerFormKey.currentState.validate()) {
                      if (pwdInputController.text ==
                          confirmPwdInputController.text) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: studentEmailIDInputController.text,
                                password: pwdInputController.text)
                            .then((currentUser) {
                          FirebaseFirestore.instance
                              .collection("users")
                              .doc(currentUser.user.uid)
                              .set({
                            'name':
                                studentNameInputController.text.toUpperCase(),
                            'role': role,
                            "admin": false,
                          });

                          return FirebaseFirestore.instance
                              .collection("student")
                              .doc(currentUser.user.uid)
                              .set({
                                "studentID": currentUser.user.uid,
                                "batch": batchInputController.text,
                                "block": block,
                                "collegeEmailID":
                                    collegeEmailIDInputController.text,
                                "courseName": courseNameInputController.text
                                    .toUpperCase(),
                                "mentorName": mentorNameInputController.text
                                    .toUpperCase(),
                                "mentorContactNumber":
                                    mentorContactNumberInputController.text,
                                "mentorEmailId":
                                    mentorEmailIDInputController.text,
                                "occupancyType": occupancyType,
                                "parentContactNumber":
                                    parentContactNumberInputController.text,
                                "parentEmailID":
                                    parentEmailIDInputController.text,
                                "parentName": parentNameInputController.text
                                    .toUpperCase(),
                                "registrationNumber":
                                    registrationNumberInputController.text,
                                "role": role.toString(),
                                "roomNumber": roomNumberInputController.text,
                                "studentContactNumber":
                                    studentContactNumberInputController.text,
                                "studentEmailID":
                                    studentEmailIDInputController.text,
                                "studentName": studentNameInputController.text
                                    .toUpperCase(),
                                "admin": false,
                                "laundryCheck": false,
                                // "laundryStatus": laundryStatus,
                                // "Plan Type": cyclePlan,
                                // "Fare": fare,
                                // "Cycles": cycles,
                              })
                              .then((result) => {
                                    sendEmailVerification(),
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        (_) => false),
                                    studentEmailIDInputController.clear(),
                                    pwdInputController.clear(),
                                    confirmPwdInputController.clear(),
                                    batchInputController.clear(),
                                    collegeEmailIDInputController.clear(),
                                    courseNameInputController.clear(),
                                    mentorEmailIDInputController.clear(),
                                    mentorContactNumberInputController.clear(),
                                    mentorNameInputController.clear(),
                                    parentContactNumberInputController.clear(),
                                    parentEmailIDInputController.clear(),
                                    registrationNumberInputController.clear(),
                                    roomNumberInputController.clear(),
                                    studentContactNumberInputController.clear(),
                                    studentNameInputController.clear(),
                                    parentNameInputController.clear(),
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
                          print("Test1");
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
