import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:package_info/package_info.dart';

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User user) async {

   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
   // int buildNumber = int.parse(packageInfo.buildNumber);


    Map<String, dynamic> userData = {
      "UserID": user.uid,
      "Last Login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      //"build_number": buildNumber,
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "Last Login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "Verify": user.emailVerified,
        //"buildNumber": buildNumber,
      });
    } else {



      await _db.collection("users").doc(user.uid).set(userData);
    }
  }

  static emailVerify(User user) async {
    if (user.emailVerified == false) {
      user.sendEmailVerification();
    } else {

    }
  }

}
