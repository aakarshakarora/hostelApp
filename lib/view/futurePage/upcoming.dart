import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

class Upcoming extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        title: Text(
          "Upcoming Page",
          style: lightSmallText.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20),
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
