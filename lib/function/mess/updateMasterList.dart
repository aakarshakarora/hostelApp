import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/function/mess/FoodItemsList.dart';
import 'package:hostel_app/function/mess/addMenu.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:hostel_app/function/mess/addFoodItem.dart';
//WIP
//Page for mess manager to update master food list for each mealofday

//TODO: Currently linked to foodlist for students. Must be linked to overall list off food items mealwise provided in firebase
import 'package:intl/intl.dart';

class updateMasterList extends StatefulWidget {
  @override
  _updateMasterListState createState() => _updateMasterListState();
}

class _updateMasterListState extends State<updateMasterList> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String dateFormatted() {
    var now = DateTime.now();

    var formatter = new DateFormat("EEE, MMM d, yy");
    String formatted = formatter.format(now);
    return formatted;
  }
//can be used for new widget to show when was menu last updated
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
            title: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text('Update Master List of Food Items'),
            ),
            // centerTitle: true,
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
              Breakfast(),
              Lunch(),
              HiTea(),
              Dinner()
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

            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                    child: Container(
                      height: 410, // To increase the height of the bottom sheet
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
//new add button must be made to add to overall list
                      // child: AddMenuItem(
                      //   mealOfDay: 'breakfast',
                      // ),
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      // child: AddMenuItem(
                      //   mealOfDay: 'lunch',
                      // ),
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      // child: AddMenuItem(
                      //   mealOfDay: 'hiTea',
                      // ),
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
                      height: 410,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      // child: AddMenuItem(
                      //   mealOfDay: 'dinner',
                      // ),
                    )));
          },
        ),
        body: FoodItemsList(
          mealOfDay: 'dinner',
        ));
  }
}
