import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';

import '../../theme/theme.dart';

class NotVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your Email ID is not Verified !! "),
            Icon(
              Icons.not_interested,
              color: Colors.red,
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "Click \"Get Link\" to receive Verification link on your Email ID  ",
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 5),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: peach,
            ),
            child: MaterialButton(
              onPressed: () {
                sendEmailVerification();
                _displaySnackBar(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
              child: Text(
                "Get Link",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
            )),
        SizedBox(height: 5),
        Text("Verify your Email ID to Login"),
      ]),
    );
  }

  Future<void> sendEmailVerification() async {
    User user = FirebaseAuth.instance.currentUser;
    user.sendEmailVerification();
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
        content: Text(
      'Link Sent on ' + FirebaseAuth.instance.currentUser.email,
      style: TextStyle(fontFamily: 'Poppins'),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
