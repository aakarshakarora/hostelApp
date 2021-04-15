import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/common/bottomBar/navigationBarLaundry.dart';
import 'package:hostel_app/common/bottomBar/navigationBarSecGuard.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Minor Issues are there

/*
Persistent Login and Role Check
*/


class SplashScreen extends StatefulWidget {
  final String text;

  SplashScreen({this.text});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _userID;
  String _switchCode;

  startTimer() async {
    var _duration = Duration(seconds: 8);
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
      case 'not_verified':{
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
      break;
      case 'Student':
        {
          print("user is student");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StudentBar()),
          );
        }
        break;
      case 'Mess InCharge':
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessBar()),
          );
          print('mess');
        }
        break;
      case 'Hostel InCharge':
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HostelBar()),
          );
          print("hostel");
        }
        break;
      case 'Laundry InCharge':
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LaundryBar()),
          );
          print("Laundry");
        }
        break;
      case 'Security InCharge':
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecGuardBar()),
          );
          print("Laundry");
        }
        break;
    }
  }

  void _roleCheck(String userID) {
    print("inside role check");
    FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .get()
        .then((value) {
      if (value.exists) {
        _switchCode = value.data()['role'];
        print("$_switchCode");
      } else {
        print("ERROR");
      }
    });
  }


  void initState() {
    print("inside init");
    super.initState();
    startTimer();
    var _user = FirebaseAuth.instance.currentUser;
    if (_user != null) {
      _userID = _user.uid;
      if (_user.emailVerified == true){
        print("user id : $_userID");
      _roleCheck(_userID);
    }else{
        _switchCode='not_verified';
        _user.sendEmailVerification();
      }

    } else {
      _switchCode = 'not_logged_in';
    }
  }
//  void initState() {
//    print("inside init");
//    super.initState();
//
//    var _user = FirebaseAuth.instance.currentUser;
//    if (_user != null) {
//      if (!_user.emailVerified) {
//        setState(() {
//          Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => LoginPage()),
//          );
//        });
//      } else {
//        setState(() {
//          _userID = _user.uid;
//          print("user id : $_userID");
//          _roleCheck(_userID);
//        });
//        //Verified
//      }
//    } else {
//      _userID = _user.uid;
//      print("user id : $_userID");
//      _roleCheck(_userID);
//      _switchCode = 'not_logged_in';
//    }
//  }

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
