import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Forgot Password Feature of Registered Email ID
 */

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _enteredEmail;
  bool _emailExists = true;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        print('email sent');
        setState(() {
          _isLoading = false;
          _emailSent = true;
          _emailExists = true;
        });
      });
    } catch (error) {
      print(error);
      print('invalid email adresss');
      setState(() {
        _emailExists = false;
        _isLoading = false;
        _emailSent = false;
      });
    }
  }

  String _validate(String email) {
    resetPassword(email);
    if (email.isEmpty) return 'Please enter a valid email id.';
    return null;
  }

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text(
          'Forgot Password',
          style: lightHeading,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Please enter your registered email id.',
                  style: darkSmallTextBold,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      kTextFieldDecoration.copyWith(labelText: 'Email : '),
                  onChanged: (val) {
                    setState(() {
                      _enteredEmail = val;
                    });
                  },
                  validator: _validate,
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: darkSmallTextBold,
                  ),
                  onPressed: () {
                    _trySubmit();
                  },
                  color: peach,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (!_emailExists)
                  Text(
                    'This email id is not registered with us.',
                    style: darkSmallTextBold,
                  ),
                if (_isLoading) CircularProgressIndicator(),
                if (_emailSent)
                  Text(
                    'An email has been sent to your registered email id.',
                    style: darkSmallTextBold,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
