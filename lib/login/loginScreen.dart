import 'package:flutter/material.dart';
import 'package:hostel_app/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/bottomBar/navigationBarStudent.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentBar()),
                );
              },
              child: Text(
                "Student",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(
              width: 2,
            ),
            FlatButton(
              color: Colors.blue,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HostelBar()),
                );
              },
              child: Text(
                "Hostel In Charge",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
