import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/theme/theme.dart';

class EditProfile extends StatefulWidget {
  final String accType;
  final String role;

  EditProfile({this.accType, this.role});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    userCred = user;
    final uid = user.uid;

    final uemail = user.email;
    studentEmail = uemail;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  static String studentID;
  static String studentEmail;
  static User userCred;

  @override
  void initState() {
    super.initState();
    studentID = getCurrentUser();
  }

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _detailsFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController oldPwdInputController = new TextEditingController();
  TextEditingController pwdInputController = new TextEditingController();

  TextEditingController confirmPwdInputController = new TextEditingController();

  TextEditingController studentContactNumberInputController =
  new TextEditingController();

  bool passwordCollapsed = true;
  bool contactnumCollapsed = true;

  String newPassword1 = '';
  String newPassword2 = '';
  String oldPassword = '';

  String newContatNum = '';

  bool authFail = false;
  bool updateFailPw = false;

  bool updateSuccessContactNum = false;
  bool updateSuccessPw = false;

  String oldPwdValidator(String value) {
    if (value == '')
      return 'Enter old password';
    else
      return null;
  }

  String pwdValidator(String value) {
    if (newPassword1 != newPassword2 && newPassword1 != null)
      return 'Password entered are not the same';
    else if (value.length > 0 && value.length < 6) {
      return 'Password should be at least 6 characters';
    } else {
      return null;
    }
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.accType);
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('student').doc(studentID);
    setState(() {
      print(docRef.toString());
    });

    return Builder(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(
              key: _scaffoldKey,
              backgroundColor: darkerBlue,
              title: Text("Profile Settings", style: lightHeading),
              centerTitle: true,
              actions: [],
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _detailsFormKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordCollapsed = !passwordCollapsed;
                                    });
                                  },
                                  icon: passwordCollapsed == true
                                      ? Icon(Icons.arrow_right)
                                      : Icon(Icons.arrow_drop_down_outlined)),
                              Text("Change Password", style: darkHeading),
                            ],
                          ),
                          if (passwordCollapsed == false)
                            SizedBox(
                              height: 18,
                            ),
                          if (passwordCollapsed ==
                              false) //i.e when it is expanded
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Old Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText3
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: peach,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText3 = !_obscureText3;
                                    });
                                  },
                                ),
                              ),
                              controller: oldPwdInputController,
                              obscureText: _obscureText3,
                              validator: oldPwdValidator,
                              onSaved: (val) {
                                oldPassword = val;
                                print(val);
                              },
                            ),
                          if (passwordCollapsed == false)
                            SizedBox(
                              height: 18,
                            ),
                          if (passwordCollapsed ==
                              false) //i.e when it is expanded
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText1
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                              onSaved: (val) {
                                newPassword1 = val;
                                print(val);
                              },
                            ),
                          if (passwordCollapsed == false)
                            SizedBox(
                              height: 18,
                            ),
                          if (passwordCollapsed == false) //ie when its expanded
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                              onSaved: (val) {
                                newPassword2 = val;
                                print(val);
                              },
                            ),
                          SizedBox(
                            height: 18,
                          ),
                          // if (authFail == true)
                          //   Text(
                          //     'Incorrect Old Password. Try again.',
                          //     style: TextStyle(
                          //       fontFamily: 'Poppins',
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // if (updateFailPw == true)
                          //   Text(
                          //     'Something went wrong. Could not update password. Try again.',
                          //     style: TextStyle(
                          //       fontFamily: 'Poppins',
                          //       color: Colors.red,
                          //     ),
                          //   ),
                          // if (updateSuccessPw)
                          //   Text(
                          //     'Password updated successfully.',
                          //     style: TextStyle(fontFamily: 'Poppins'),
                          //   ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      contactnumCollapsed =
                                      !contactnumCollapsed;
                                    });
                                  },
                                  icon: contactnumCollapsed == true
                                      ? Icon(Icons.arrow_right)
                                      : Icon(Icons.arrow_drop_down_outlined)),
                              Text("Change Contact Number", style: darkHeading),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          if (contactnumCollapsed == false) //ie when expanded
                            TextFormField(
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Contact Number',
                              ),
                              keyboardType: TextInputType.phone,
                              controller: studentContactNumberInputController,
                              validator: validateMobile,
                              onSaved: (val) {
                                newContatNum = val;
                                print(val);
                              },
                            ),
                          SizedBox(
                            height: 18,
                          ),
                          // if (updateSuccessContactNum)
                          //   Text(
                          //     'Contact number updated successfully.',
                          //     style: TextStyle(fontFamily: 'Poppins'),
                          //   ),
                          if (passwordCollapsed == false ||
                              contactnumCollapsed == false)
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text("Submit"),
                                color: peach,
                                textColor: Colors.white,
                                onPressed: () async {
                                  _detailsFormKey.currentState.save();
                                  if (_detailsFormKey.currentState.validate()) {
                                    print('validated');
                                    //updating contact number
                                    print(newContatNum);
                                    if (newContatNum != '') {
                                      print('updating contact num');
                                      print('Acc type is');
                                      print(widget.accType);
                                      //number update for student
                                      if (widget.accType == 'student') {
                                        print('student');
                                        FirebaseFirestore.instance
                                            .collection("student")
                                            .doc(studentID)
                                            .update({
                                          'studentContactNumber': newContatNum,
                                        }).then((_) {
                                          FocusScope.of(context).unfocus();
                                          studentContactNumberInputController
                                              .clear();
                                          setState(() {
                                            updateSuccessContactNum = true;
                                          });
                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Contact number has been updated successfully.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          // Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          FocusScope.of(context).unfocus();

                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Something went wrong. Try again.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      }
                                      //updating contact num for hostel employee
                                      else if (widget.accType ==
                                          'hostel Employee') {
                                        print('hostel emp');
                                        FirebaseFirestore.instance
                                            .collection("hostel Employee")
                                            .doc(studentID)
                                            .update({
                                          'contactNumberHostel': newContatNum,
                                        }).then((_) {
                                          FocusScope.of(context).unfocus();
                                          studentContactNumberInputController
                                              .clear();
                                          setState(() {
                                            updateSuccessContactNum = true;
                                          });
                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Contact number has been updated successfully.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          // Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          FocusScope.of(context).unfocus();
                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Something went wrong. Try again.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      }
                                    }
                                    if (oldPassword != '' &&
                                        newPassword1 != '' &&
                                        newPassword2 != '') {
                                      AuthCredential credential =
                                      EmailAuthProvider.credential(
                                          email: studentEmail,
                                          password: oldPassword);
                                      userCred
                                          .reauthenticateWithCredential(
                                          credential)
                                          .then((value) {
                                        setState(() {
                                          authFail = false;
                                        });
                                        print('Authentication successful');
                                        userCred
                                            .updatePassword(newPassword1)
                                            .then((value) {
                                          FocusScope.of(context).unfocus();
                                          print('Password Sucessfully updated');
                                          oldPwdInputController.clear();
                                          pwdInputController.clear();
                                          confirmPwdInputController.clear();
                                          setState(() {
                                            updateSuccessPw = true;
                                          });
                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Password has been changed successfully.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          // Navigator.pop(context);
                                        }).onError((error, stackTrace) {
                                          print(error);
                                          setState(() {
                                            updateFailPw = true;
                                          });
                                          FocusScope.of(context).unfocus();
                                          final snackBar = SnackBar(
                                            content: Container(
                                              height: 80,
                                              child: Text(
                                                  'Password update failed. Try again.',
                                                  style:
                                                  lightSmallText.copyWith(
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      }).onError((error, stackTrace) {
                                        print(error);
                                        print(authFail);
                                        setState(() {
                                          authFail = true;
                                        });
                                        FocusScope.of(context).unfocus();
                                        final snackBar = SnackBar(
                                          content: Container(
                                            height: 80,
                                            child: Text(
                                                'Old password does not match. Try again.',
                                                style: lightSmallText.copyWith(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      });
                                    }
                                  }
                                }),
                          Expanded(child: Container()),
                          Divider(thickness: 0.7),
                          widget.role == 'Student'
                              ? Text(
                              'To update Parents details, please contact the administrator.',
                              style: darkSmallTextBold)
                              : Text(
                              'To Update other details, contact the administrator')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
