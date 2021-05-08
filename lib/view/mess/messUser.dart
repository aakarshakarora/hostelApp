import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';

import 'package:hostel_app/theme/theme.dart';

class MessUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text(
          "Welcome UserName!",
          style: lightSmallText.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            );
          },
        ),
      ),
      body: Center(
          child: Text(
            "This Page Will Come in Next Update",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          )),
    );
  }
}
signOut() {
  FirebaseAuth.instance.signOut();
}

