import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/form/Laundry/addRequest.dart';

class PastRequest extends StatefulWidget {
  @override
  _PastRequestState createState() => _PastRequestState();
}

class _PastRequestState extends State<PastRequest> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser.uid;

  String getCurrentUser() {
    final User user = _auth.currentUser;
    final uid = user.uid;

    final uemail = user.email;
    print(uid);
    print(uemail);
    return uid.toString();
  }

  static String studentID;
  void initState() {
    // TODO: implement initState
    super.initState();
    studentID = getCurrentUser();
  }

  bool showSpinner = false;

  var firestoreDB = FirebaseFirestore.instance
      .collection('LaundryRequest')
      .where('status', isEqualTo: 'Ready' )
      .snapshots();

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef =
    FirebaseFirestore.instance.collection('User').doc(studentID);
    setState(() {
      print(docRef.toString());
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Past Request",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: 'Poppins',
          ),),
      ),
      body: Container(
        child: StreamBuilder(
          stream: firestoreDB,
          builder: (ctx, opSnapshot) {
            if (opSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            final reqDocs = opSnapshot.data.documents;
            print('length ${reqDocs.length}');
            return ListView.builder(
              itemCount: reqDocs.length,
              itemBuilder: (ctx, index) {
                if (reqDocs[index].get('studentID').toString().contains(userId))
                  return RequestCard(reqDoc: reqDocs[index]);
                return Container(
                  height: 0,
                );
              },
            );
          },
        ),
      ),
    );
  }
}