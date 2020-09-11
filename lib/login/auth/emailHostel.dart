import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/login/registerHostel.dart';
import 'package:hostel_app/theme/theme.dart';

import '../loginScreen.dart';

class HostelEmail extends StatefulWidget {
  @override
  _HostelEmailState createState() => _HostelEmailState();
}

class _HostelEmailState extends State<HostelEmail> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text(
            "Welcome to MUJ Hostel APP",
            style: lightSmallText.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
          //centerTitle: true,
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
          child: Container(
            padding: EdgeInsets.all(50),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'You will be Logged in as Hostel In Charge',
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
                    controller: _emailController,
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Enter Email ID:'),
                    validator: (String value) {
                      if (value.isEmpty) {
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
                      labelText: 'Enter Password:',
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
                    ),
                    autofocus: false,
                    obscureText: _obscureText,
                    validator: (String value) {
                      if (value.isEmpty) {
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
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: peach,
                      ),
                      child: FlatButton(
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _signInWithEmailAndPassword();
                          }
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
                              builder: (ctx) => HostelRegister()));
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
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HostelBar()),
        );
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }
//
//  void _roleCheck() async {
//    var db = FirebaseFirestore.instance.collection('student').snapshots();
//    StreamBuilder(
//      stream: db,
//      builder: (ctx, snapshot) {
//        if (snapshot.connectionState == ConnectionState.waiting)
//          return Center(child: CircularProgressIndicator());
//
//        if (snapshot.data.get('role') == 'Student') {
//          setState(() {
//
//          });
//        }
//        else {
//          setState(() {
//            _displaySnackBar(context);
//
//          });
//        }
//        return null;
//      },);
//
//
//  }
//  _displaySnackBar(BuildContext context) {
//    final snackBar = SnackBar(
//        content: Text(
//          'Login Failed',
//          style: TextStyle(fontFamily: 'Poppins'),
//        ));
//    Scaffold.of(context).showSnackBar(snackBar);
//  }
}
