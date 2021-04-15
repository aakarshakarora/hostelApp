import 'package:flutter/material.dart';


class NotVerified extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        color: Colors.white,
        child: Center(child :Text("Please verify your email before continuing ")),
      ),),
    );
  }
}
