import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class SplashScreen extends StatefulWidget {
  final String text;

  SplashScreen(this.text);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkerBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Text(
                widget.text == null ? 'Hostel App' : widget.text,
                style: lightHeading.copyWith(color: peach, fontSize: 28),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(peach),
              strokeWidth: 5,
            ),
          )
        ],
      ),
    );
  }
}
