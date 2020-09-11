import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/login/auth/emailHostel.dart';
import 'package:hostel_app/login/auth/emailStudent.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkerBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: kloginScreenButtonStyle,
              child: FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentEmail()),
                  );
                },
                child: Text(
                  "Student",
                  style: lightHeading,
                ),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Container(
              decoration: kloginScreenButtonStyle,
              child: FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HostelEmail()),
                  );
                },
                child: Text(
                  "Hostel In Charge",
                  style: lightHeading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
