import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/function/mess/FoodItemsList.dart';
import 'package:hostel_app/function/mess/addMenu.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working fine.
//Mess update form: The mess menu is updated from here
//4 tabs- 1)Breakfast, 2)Lunch, 3)Hi Tea and 4)Dinner
import 'package:intl/intl.dart';

class MessUpdate extends StatefulWidget {
  @override
  _MessUpdateState createState() => _MessUpdateState();
}

class _MessUpdateState extends State<MessUpdate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Displays the current date for the mess, is displayed in the Appbar
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
                      MaterialPageRoute(builder: (context) => MessBar()),
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

//BreakFast Tab
class Breakfast extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //showModalBottomSheet(context: context,
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'breakfast',
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'breakfast',
        ));
  }
}

//Lunch Tab
class Lunch extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //showModalBottomSheet(context: context,
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'lunch',
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'lunch',
        ));
  }
}

//Hi Tea tab
class HiTea extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //showModalBottomSheet(context: context,
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'hiTea',
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'hiTea',
        ));
  }
}

//Dinner Tab
class Dinner extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMenuItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //showModalBottomSheet(context: context,
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                        child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'dinner',
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'dinner',
        ));
  }
}
