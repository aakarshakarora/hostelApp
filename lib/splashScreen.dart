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
            MaterialPageRoute(builder: (context) => MessUser()),
          );
          print('mess');
        }
        break;
      case 'Hostel InCharge':
        {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HostelBar()),
        );
          print("hostel");
        }
        break;

    }
  }
  void _roleCheck(String userID){
    print("inside role check");
    FirebaseFirestore.instance.collection('users').doc(userID).get().then((value) {
      if(value.exists){

        _switchCode=value.data()['role'];
        print("$_switchCode");
      }else{
        print("ERROR");
      }
    });

  }

  void initState() {
    print("inside init");
    super.initState();
    startTimer();
    var _user = FirebaseAuth.instance.currentUser;
    if ( _user!= null) {
      _userID= _user.uid;
      print("user id : $_userID");
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
