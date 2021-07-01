import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/function/mess/FoodItemsList.dart';
import 'package:hostel_app/function/mess/addMenu.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/function/mess/addFoodItem.dart';
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

  List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String _selectedDay =
      'Monday'; //Automatically Selected at time of opening page

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
            title: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Color(0xFF5A86A3),
              ),
              child: DropdownButton(
                value: _selectedDay,
                onChanged: (newchoice) {
                  setState(() {
                    _selectedDay = newchoice;
                  });
                },
                items: _days.map((day) {
                  return DropdownMenuItem(
                    child: Text(
                      day,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'Poppins'),
                    ),
                    value: day,
                  );
                }).toList(),
              ),
            ),
            //centerTitle: true,
            // CHANGE IF NEEDED

            // Text(
            //   'Mess Menu for ' + dateFormatted(),
            //   style: lightSmallText.copyWith(
            //       fontWeight: FontWeight.bold, fontSize: 20),
            // ),
            // centerTitle: true,

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
          ),
          body: TabBarView(
            children: [
              Breakfast(
                selectedDay: _selectedDay,
              ),
              Lunch(
                selectedDay: _selectedDay,
              ),
              HiTea(
                selectedDay: _selectedDay,
              ),
              Dinner(
                selectedDay: _selectedDay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//BreakFast Tab
class Breakfast extends StatelessWidget {
  final String selectedDay;
  Breakfast({this.selectedDay});
  Widget buildBottomSheet(BuildContext context) {
    return AddMenuItem();
  }

//what is the use of this ^^
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
                      height: 410, // To increase the height of the bottom sheet
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),

                      child: AddMenuItem(
                        mealOfDay: 'Breakfast',
                        selectedDay: selectedDay,
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'Breakfast',
          selectedDay: selectedDay,
        ));
  }
}

//Lunch Tab
class Lunch extends StatelessWidget {
  final String selectedDay;
  Lunch({this.selectedDay});
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'Lunch',
                        selectedDay: selectedDay,
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'Lunch',
          selectedDay: selectedDay,
        ));
  }
}

//Hi Tea tab
class HiTea extends StatelessWidget {
  final String selectedDay;
  HiTea({this.selectedDay});
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'Hi-Tea',
                        selectedDay: selectedDay,
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'Hi-Tea',
          selectedDay: selectedDay,
        ));
  }
}

//Dinner Tab
class Dinner extends StatelessWidget {
  final String selectedDay;
  Dinner({this.selectedDay});
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: AddMenuItem(
                        mealOfDay: 'Dinner',
                        selectedDay: selectedDay,
                      ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'Dinner',
          selectedDay: selectedDay,
        ));
  }
}
