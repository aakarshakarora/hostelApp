import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:intl/intl.dart';
import 'package:hostel_app/theme/theme.dart';
import '../../theme/theme.dart';

//For the Student who will be viewing the menu
/* Status: Working fine.
*/
class MessMenu extends StatelessWidget {
  //For displaying current date on the Appbar
  String dateFormatted() {
    var now = DateTime.now();

    var formatter = new DateFormat("EEE, MMM d, yy");
    String formatted = formatter.format(now);

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkerBlue,
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
                  text: 'Breakfast',
                ),
                Tab(
                  text: 'Lunch',
                ),
                Tab(
                  text: 'Hi-Tea',
                ),
                Tab(text: 'Dinner'),
              ],
            ),
            title: Text(
              'Mess Menu for ' + dateFormatted(),
              style: lightSmallText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Breakfast(),
              Lunch(),
              HiTea(),
              Dinner(),
            ],
          ),
        ),
      ),
    );
  }
}

//Breakfast tab
class Breakfast extends StatelessWidget {
  @override
  var firestoreDB =
      FirebaseFirestore.instance.collection("messMenu").snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: firestoreDB,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Column(
                                children: [
                                  for (var i in snapshot.data.docs[index]
                                      .get('breakfast'))
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 3.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                i.toString(),
                                                style: darkHeading.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ))),
                                ],
                              ),
                            );
                          }),
                    );
                  });
            }),
      ),
    );
  }
}

//Lunch Tab
class Lunch extends StatelessWidget {
  var firestoreDB =
      FirebaseFirestore.instance.collection("messMenu").snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: firestoreDB,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Column(
                                children: [
                                  for (var i
                                      in snapshot.data.docs[index].get('lunch'))
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 3.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                i.toString(),
                                                style: darkHeading.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ))),
                                ],
                              ),
                            );
                          }),
                    );
                  });
            }),
      ),
    );
  }
}

//Hi Tea Tab
class HiTea extends StatelessWidget {
  var firestoreDB =
      FirebaseFirestore.instance.collection("messMenu").snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: firestoreDB,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Column(
                                children: [
                                  for (var i
                                      in snapshot.data.docs[index].get('hiTea'))
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 3.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                i.toString(),
                                                style: darkHeading.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ))),
                                ],
                              ),
                            );
                          }),
                    );
                  });
            }),
      ),
    );
  }
}

//Dinner tab
class Dinner extends StatelessWidget {
  var firestoreDB =
      FirebaseFirestore.instance.collection("messMenu").snapshots();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder(
            stream: firestoreDB,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: new ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Column(
                                children: [
                                  for (var i in snapshot.data.docs[index]
                                      .get('dinner'))
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Card(
                                            elevation: 3.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                i.toString(),
                                                style: darkHeading.copyWith(
                                                    fontSize: 15),
                                              ),
                                            ))),
                                ],
                              ),
                            );
                          }),
                    );
                  });
            }),
      ),
    );
  }
}
