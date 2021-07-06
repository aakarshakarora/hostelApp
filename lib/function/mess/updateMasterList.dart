import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/bottomBar/navigationBarMess.dart';
import 'package:hostel_app/common/bottomBar/navigationBarStudent.dart';
import 'package:hostel_app/theme/theme.dart';
import '../../theme/theme.dart';
import 'MasterFoodItemList.dart';
import 'addMasterMenuItem.dart';

//For the Student who will be viewing the menu
/* Status: Working fine.
*/
class UpdateMasterList extends StatelessWidget {
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
              'Food Master List',
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
  // Widget buildBottomSheet(BuildContext context) {
  //   return AddMasterMenuItem();
  // }

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
                builder: (context) => Container(
                      height: 200 ,
                      // To increase the height of the bottom sheet

                      child: AddMasterMenuItem(
                mealOfDay: 'BreakfastMenu',
                documentName: 'BreakfastSuggestion',
                      ),
                    ));
          },
        ),
        body: MasterFoodItemsList(
          mealOfDay: 'BreakfastMenu',
          documentName: 'BreakfastSuggestion',
        ));
  }
}

//Lunch Tab
class Lunch extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMasterMenuItem();
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
                      height: 200,
                      // To increase the height of the bottom sheet
                      child: AddMasterMenuItem(
                        mealOfDay: 'LunchMenu',
                        documentName: 'LunchSuggestion',
                      ),
                    )));
          },
        ),
        body: MasterFoodItemsList(
          mealOfDay: 'LunchMenu',
          documentName: 'LunchSuggestion',
        ));
  }
}

//Hi Tea Tab
class HiTea extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMasterMenuItem();
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
                      height: 200,
                      // To increase the height of the bottom sheet


                      child: AddMasterMenuItem(
                        mealOfDay: 'Hi-TeaMenu',
                        documentName: 'Hi-TeaSuggestion',
                      ),
                    )));
          },
        ),
        body: MasterFoodItemsList(
          mealOfDay: 'Hi-TeaMenu',
          documentName: 'Hi-TeaSuggestion',
        ));
  }
}

//Dinner tab
class Dinner extends StatelessWidget {
  Widget buildBottomSheet(BuildContext context) {
    return AddMasterMenuItem();
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
                      height: 200,
                      // To increase the height of the bottom sheet
                    
                      child: AddMasterMenuItem(
                        mealOfDay: 'DinnerMenu',
                        documentName: 'DinnerSuggestion',
                      ),
                    )));
          },
        ),
        body: MasterFoodItemsList(
          mealOfDay: 'DinnerMenu',
          documentName: 'DinnerSuggestion',
        ));
  }
}
