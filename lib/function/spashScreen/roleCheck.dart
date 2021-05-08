import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_app/common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/common/bottomBar/navigationBarLaundry.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/common/bottomBar/navigationBarSecGuard.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/function/spashScreen/authHelper.dart';
import 'package:hostel_app/function/spashScreen/not%20_verified.dart';
import 'package:hostel_app/login/login_SignUp%20page.dart';

import '../../splashScreen.dart';


class RoleCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc.data();
                  if (user['role'] == 'Student' && user['Verify'] == true) {
                    return StudentBar();
                  } else if (user['role'] == 'Mess InCharge' &&
                      user['Verify'] == true) {
                    return MessBar();
                  } else if (user['role'] == 'Hostel InCharge' &&
                      user['Verify'] == true) {
                    return HostelBar();
                  } else if (user['role'] == 'Laundry InCharge' &&
                      user['Verify'] == true) {
                    return LaundryBar();
                  } else if (user['role'] == 'Security InCharge' &&
                      user['Verify'] == true) {
                    return SecGuardBar();
                  } else if (user['Verify'] == false) {
                    return NotVerified();
                  } else {
                    return LoginPage();
                  }
                } else {
                  return Material(
                    child: SplashScreen(),
                  );
                }
              },
            );
          }
          return LoginPage();
        });
  }
}
