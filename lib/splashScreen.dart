import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/login/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userID;
  String _switchCode;

  startTimer() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    switch (_switchCode) {
      case 'not_logged_in':
        {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        }
        break;
      case 'student':
        {
          print("user is student");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentBar()),
          );
        }
        break;
      case 'mess':
        {
          print('mess');
        }
        break;
      case 'hostel':
        {
          print("hostel");
        }
        break;
      default :
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
        break;
    }
  }
  void _roleCheck(String userID){
    FirebaseFirestore.instance.collection('users').doc(userID).get().then((value) {
      if(value.exists){
        _switchCode=value.data()['role'];
      }else{
        print("ERROR");
      }
    });

  }

  void initState() {
    super.initState();
    startTimer();
    var _user = FirebaseAuth.instance.currentUser;
    if ( _user!= null) {
      _userID= _user.uid;
      _roleCheck(_userID);
    } else {
      _switchCode = 'not_logged_in';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              child: Text(
                'Hostel App',
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 5,
            ),
          )
        ],
      ),
    );
  }
}
