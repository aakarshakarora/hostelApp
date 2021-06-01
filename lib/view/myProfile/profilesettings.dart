import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostel_app/theme/theme.dart';

class ProfileSettings extends StatefulBuilder {
  @override
  _ProfileSettingsState _createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _obscureText1 = true;
  bool _obscureText2 = true;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _detailsFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController pwdInputController = new TextEditingController();

  TextEditingController confirmPwdInputController = new TextEditingController();

  TextEditingController studentContactNumberInputController =
      new TextEditingController();

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password should be at least 6 characters';
    } else {
      return null;
    }
  }

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
  void initState() {
    super.initState();
    print("Hllp");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            body: Container(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _detailsFormKey,
                  child: Column(
                    children: <Widget>[
                      Text("Change Password", style: darkHeading),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
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
                      ),
                      SizedBox(
                        height: 18,
                      ),
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
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text("Contact Number", style: darkHeading),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Contact Number:',
                        ),
                        keyboardType: TextInputType.phone,
                        controller: studentContactNumberInputController,
                        validator: validateMobile,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("Submit"),
                          color: peach,
                          textColor: Colors.white,
                          onPressed: () {})
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
