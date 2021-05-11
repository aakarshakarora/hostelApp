import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

import '../../common/bottomBar/navigationBarStudent.dart';

class LaundryCycles extends StatefulWidget {
  final int cycles;

  LaundryCycles(this.cycles);

  @override
  _LaundryCyclesState createState() => _LaundryCyclesState();
}

class _LaundryCyclesState extends State<LaundryCycles> {
  int cycles;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkerBlue,
            actions: [Text('Cycles Left: ' + widget.cycles.toString())],
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentBar()),
                    );
                  },
                );
              },
            ),
            bottom: TabBar(
              indicatorColor: peach,
              indicatorWeight: 4,
              labelStyle: lightTinyText.copyWith(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: 'Add New Request',
                ),
                Tab(
                  text: 'Past Request',
                ),
              ],
            ),
            title: Text(
              'Laundry  ',
              style: lightSmallText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              AddRequest(widget.cycles),
              PastRequest(),
            ],
          ),
        ),
      ),
    );
  }
}

class AddRequest extends StatefulWidget {
  final cycles;

  AddRequest(this.cycles);

  @override
  _AddRequestState createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentID = getCurrentUser();
  }

  String status = "Pending";
  DateTime requestDate = DateTime.now();
  TextEditingController customController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

  // ignore: missing_return
  String checkEmpty(String value) {
    if (value.isEmpty) {
      setState(() {
        showSpinner = false;
      });
      return 'Field Required';
    }
  }

  Widget _buildTextField() {
    return TextFormField(
      autofocus: true,
      textAlign: TextAlign.center,
      controller: customController,
      keyboardType: TextInputType.number,
      cursorColor: Colors.cyan,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
        hintText: "Cloth Count",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 2.0),
        ),
      ),
      style: TextStyle(
          fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w600),
      // ignore: missing_return
      validator: (String value) {
        if (value.isEmpty) {
          return "Cloth Count is required!";
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    customController.dispose();
  }

  createAlertDialog(BuildContext context, docRef) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              " Enter Total Clothes:",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            content: Container(
                height: MediaQuery.of(context).size.width * 0.4,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildTextField(),
                      Text("*Please consider socks as a pair",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontFamily: 'Poppins'))
                    ],
                  ),
                )),
            actions: [
              MaterialButton(
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  FirebaseFirestore.instance.collection('LaundryRequest').add({
                    "clothCount": int.parse(customController.text),
                    "studentID": docRef,
                    "status": status,
                    "requestDate": requestDate,
                  });

                  Navigator.of(context).pop();
                  customController.clear();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        });
  }

  var firestoreDB = FirebaseFirestore.instance
      .collection('LaundryRequest')
      .where('status', isEqualTo: 'Pending')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('student').doc(studentID);
    setState(() {
      print(docRef.toString());
    });
    return Scaffold(
      floatingActionButton: widget.cycles == null || widget.cycles == 0
          ? Column(mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: const Color(0xff03dac6),
                  foregroundColor: Colors.black,
                  onPressed: () {
                    // Respond to button press
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 5,),
                Text("No Cycles Available!!"),
              ],
            )
          : Column(
              children: [
                FloatingActionButton(
                  backgroundColor: const Color(0xff03dac6),
                  foregroundColor: Colors.black,
                  onPressed: () {
                    createAlertDialog(context, docRef);
                    // Respond to button press
                  },
                  child: Icon(Icons.add),
                ),
              ],
            ),
      body: Container(
        child: StreamBuilder(
          stream: firestoreDB,
          builder: (ctx, opSnapshot) {
            if (opSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            final reqDocs = opSnapshot.data.docs;
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

class RequestCard extends StatefulWidget {
  RequestCard({this.reqDoc});

  final dynamic reqDoc;

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    final clothCount = widget.reqDoc.get("clothCount");
    final status = widget.reqDoc.get("status");
    final requestDate =
        (widget.reqDoc.get('requestDate') as Timestamp).toDate().toString();
    final requestId = widget.reqDoc.id;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Order Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins'),
              ),
              Text("Order Date: $requestDate",
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppins')),
              Text(
                "Order id: '$requestId'",
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total Cloth Count: $clothCount",
                    style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                  ),
                  Text(
                    "Status: $status",
                    style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              // Text(
              //   "Request Date: ",
              //   style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      .where('status', isEqualTo: 'Ready')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('student').doc(studentID);
    setState(() {
      print(docRef.toString());
    });
    return Scaffold(
      body: Container(
        child: StreamBuilder(
          stream: firestoreDB,
          builder: (ctx, opSnapshot) {
            if (opSnapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            final reqDocs = opSnapshot.data.docs;
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
