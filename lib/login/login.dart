import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/function/spashScreen/roleCheck.dart';

import 'package:hostel_app/theme/theme.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:hostel_app/login/forgotPassword/forgot_password.dart';
import 'login_SignUp page.dart';

//Status: Working Fine

/*
Login Page for Registered User
*/

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;
  bool _obscureText = true;
  String _error, _error1;
  bool showSpinner = false;

//Resend Link for Email Verification
  Future<void> sendEmailVerification() async {
    User user = await _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

//Shows Error Displayed from Console
  Widget _buildError() {
    setState(() {
      showSpinner = false;
    });
    if (_error != null) {
      return Container(
          padding: EdgeInsets.all(10),
          color: Colors.yellowAccent,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.error),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(_error, overflow: TextOverflow.clip),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _error = null;
                      });
                    },
                  )
                ],
              ),
            ],
          ));
    } else {
      return Container(
        height: 0,
      );
    }
  }

//Shows Email Verification Error
  Widget _verifyError() {
    setState(() {
      showSpinner = false;
    });
    if (_error1 != null) {
      return Container(
          padding: EdgeInsets.all(10),
          color: Colors.yellowAccent,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.error),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(_error1, overflow: TextOverflow.clip),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _error1 = null;
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.green,
                ),
                child: FlatButton(
                    onPressed: sendEmailVerification,
                    child: Text("Click here to Send Verification Code")),
              ),
            ],
          ));
    } else {
      return Container(
        height: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkerBlue,
            title: Text(
              "Login",
              style: lightSmallText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildError(),
                _verifyError(),
                Container(
                  padding: EdgeInsets.all(50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Please enter your registered credentials.',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          padding: const EdgeInsets.all(16),
                          alignment: Alignment.center,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Enter Email ID:'),
                          validator: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                showSpinner = false;
                              });
                              return 'Field Required';
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: kTextFieldDecoration.copyWith(
                              suffixIcon: IconButton(
                                color: peach,
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              labelText: 'Enter Password:'),
                          autofocus: false,
                          obscureText: _obscureText,
                          validator: (String value) {
                            if (value.isEmpty) {
                              setState(() {
                                showSpinner = false;
                              });
                              return 'Field Required';
                            }
                            return null;
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: peach,
                            ),
                            child: FlatButton(
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              onPressed: () async {
                                await Future.value(_error);
                                setState(() {
                                  if (_error != null) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } else {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                  }
                                });
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();
                                print(_emailController.text);
                                print(_passwordController.text);
                                _signInWithEmailAndPassword();
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                          child: Text('Forgot Password?',
                              style: darkSmallTextBold),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => ForgotPassword()));
                          },
                        ),
                        Text(
                          "Don't have an account?",
                          style: darkSmallText,
                        ),
                        FlatButton(
                          child: Text(
                            "Sign Up here!",
                            style: darkSmallTextBold,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => LoginPage()));
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            _success == null
                                ? ''
                                : (_success
                                    ? 'Successfully signed in ' + _userEmail
                                    : 'Sign in failed'),
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ))
          .user;

      if (user != null) {
        if (!user.emailVerified) {
          setState(() {
            _error1 =
                "Your email has not been verified. You must've got an email verification request.";
          });
        } else {
          setState(() {
            _success = true;
            _userEmail = user.email;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RoleCheck()),
            );
          });
          //Verified
        }
      } else {
        setState(() {
          _success = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _error = e.message;
      });
    }
  }
}
