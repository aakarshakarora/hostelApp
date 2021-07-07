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
  Widget buildBottomSheet(BuildContext context) {
    return AddMasterMenuItem();
  }

//what is the use of this ^^
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MasterFoodItemsList(
          mealOfDay: 'BreakfastMenu',
          documentName: 'BreakfastSuggestion',
        ),
      bottomNavigationBar: BottomAppBar(
        //----use if second style button----
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        //----------------------------------
        child: Container(
            height:50,
          color: darkerBlue,
          //---------------buttonstart(style1)-------------
          // child: TextButton(
          //   // child: Text("ADD",style: TextStyle(color: Colors.white,fontSize: 20),),
          //   child: Icon(Icons.add,color: Colors.white,size: 35,),
          //   onPressed: () {
          //   //showModalBottomSheet(context: context,
          //   showModalBottomSheet(
          //       context: context,
          //       isScrollControlled: true,
          //       builder: (context) => Container(
          //         height: 200 ,
          //         // To increase the height of the bottom sheet
          //
          //         child: AddMasterMenuItem(
          //           mealOfDay: 'BreakfastMenu',
          //           documentName: 'BreakfastSuggestion',
          //         ),
          //       ));
          // },
          // ),
          //-------------------buttonend----------------
        ),
      ),
      //------2nd style button(comment buttonstart to buttonend before using this)-------
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //-------------------------buttonend(style2)-----------------------------------------
    );
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
        body: MasterFoodItemsList(
          mealOfDay: 'LunchMenu',
          documentName: 'LunchSuggestion',
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height:50,
          color: darkerBlue,
        ),
      ),
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
                  mealOfDay: 'LunchMenu',
                  documentName: 'LunchSuggestion',
                ),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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
        body: MasterFoodItemsList(
          mealOfDay: 'Hi-TeaMenu',
          documentName: 'Hi-TeaSuggestion',
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height:50,
          color: darkerBlue,
        ),
      ),
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
                  mealOfDay: 'Hi-TeaMenu',
                  documentName: 'Hi-TeaSuggestion',
                ),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
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
        body: MasterFoodItemsList(
          mealOfDay: 'DinnerMenu',
          documentName: 'DinnerSuggestion',
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height:50,
          color: darkerBlue,
        ),
      ),
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
                  mealOfDay: 'DinnerMenu',
                  documentName: 'DinnerSuggestion',
                ),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
