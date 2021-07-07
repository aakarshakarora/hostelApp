import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/function/mess/addFoodItem.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working fine
class AddMenuItem extends StatefulWidget {
  String mealOfDay;
  String selectedDay;

  AddMenuItem({this.mealOfDay, this.selectedDay});

  @override
  _AddMenuItemState createState() => _AddMenuItemState();
}

class _AddMenuItemState extends State<AddMenuItem> {
  final _firestore = FirebaseFirestore.instance;
  final messController = TextEditingController();
  List<String> _breakfastSelected;
  List<String> _lunchSelected;
  List<String> _hiTeaSelected;
  List<String> _dinnerSelected;

  Future<Suggestion> getSuggestions() async {
    List<String> breakfastSuggestion = [];
    List<String> lunchSuggestion = [];
    List<String> hiTeaSuggestion = [];
    List<String> dinnerSuggestion = [];

    Suggestion suggestion = Suggestion();
    await _firestore
        .collection('messMenu')
        .doc('EzkkLnYtQPbSDLxMToZm')
        .collection('MessMenu')
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc.id);
        if (doc.id == 'BreakfastSuggestion') {
          breakfastSuggestion = (doc['BreakfastMenu'] as List)
              ?.map((item) => item as String)
              ?.toList();
          suggestion.breakfastSuggestion = breakfastSuggestion;
        } else if (doc.id == 'LunchSuggestion') {
          lunchSuggestion = (doc['LunchMenu'] as List)
              ?.map((item) => item as String)
              ?.toList();
          suggestion.lunchSuggestion = lunchSuggestion;
        } else if (doc.id == 'Hi-TeaSuggestion') {
          hiTeaSuggestion = (doc['Hi-TeaMenu'] as List)
              ?.map((item) => item as String)
              ?.toList();
          suggestion.hiTeaSuggestion = hiTeaSuggestion;
        } else if (doc.id == 'DinnerSuggestion') {
          dinnerSuggestion = (doc['DinnerMenu'] as List)
              ?.map((item) => item as String)
              ?.toList();
          suggestion.dinnerSuggestion = dinnerSuggestion;
        }
      });
    });

    return suggestion;
  }

  // List<DocumentSnapshot> getBreakfastData(){
  //   FirebaseFirestore.instance.collection('messMenu').get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((result) {
  //       return result.data()["Breakfast"]["Monday"];
  //     });
  //   });
  // }
  @override
  void initState() {
    // TODO: implement initState
    _breakfastSelected = <String>[];
    _lunchSelected = <String>[];
    _hiTeaSelected = <String>[];
    _dinnerSelected = <String>[];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String newFoodTitle;
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Text(
              "Add Food Item",
              style: darkHeading,
            ),
            SizedBox(
              height: 20,
            ),

            // TextFormField --------------------------
            TextFormField(

              controller: messController,
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'Search Food Item',prefixIcon: Icon(Icons.search)),

              // ignore: missing_return
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Field is required';
                }
              },
              onSaved: (String value) {
                widget.mealOfDay = value;
              },
            ),

            // SizedBox(height: 5.0,),
            // -----------------------------------

            // ----- Something New ---------------
            FutureBuilder<Suggestion>(
              future: getSuggestions(),
              builder:
                  (BuildContext context, AsyncSnapshot<Suggestion> snapshot) {
                if (!snapshot.hasData) {
                  // while data is loading:
                  return CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  );
                } else {
                  Suggestion suggestion = snapshot.data;
                  print(suggestion);
                  return FoodItemList(
                    foodItems: widget.mealOfDay == 'Breakfast'
                        ? suggestion.breakfastSuggestion
                        : widget.mealOfDay == 'Lunch'
                            ? suggestion.lunchSuggestion
                            : widget.mealOfDay == 'Hi-Tea'
                                ? suggestion.hiTeaSuggestion
                                : suggestion.dinnerSuggestion,
                    foodItemsSelected: widget.mealOfDay == 'Breakfast'
                        ? _breakfastSelected
                        : widget.mealOfDay == 'Lunch'
                            ? _lunchSelected
                            : widget.mealOfDay == 'Hi-Tea'
                                ? _hiTeaSelected
                                : _dinnerSelected,
                  );
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: kloginScreenButtonStyle.copyWith(color: peach),
              child: FlatButton(
                child: Text(
                  "Add",
                  style: kbuttonTextStyle,
                ),
                onPressed: () async {
                  print(newFoodTitle);
                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection('messMenu')
                      .doc('EzkkLnYtQPbSDLxMToZm');

                  DocumentSnapshot doc = await docRef.get();

                  Map<String, dynamic> docData = doc[widget.mealOfDay];

                  List<dynamic> updatedList =
                      doc[widget.mealOfDay][widget.selectedDay] != null
                          ? doc[widget.mealOfDay][widget.selectedDay]
                          : [];

                  List<String> selectedList = widget.mealOfDay == 'Breakfast'
                      ? _breakfastSelected
                      : widget.mealOfDay == 'Lunch'
                          ? _lunchSelected
                          : widget.mealOfDay == 'Hi-Tea'
                              ? _hiTeaSelected
                              : _dinnerSelected;

                  for (String item in selectedList) {
                    if (!updatedList.contains(item)) {
                      updatedList.add(item);
                    }
                  }
                  print(updatedList.toString());

                  // docData = {
                  //   'Thursday': ['Tea'],
                  //   'Monday': ['Tea', 'Hot Milk'],
                  //   'Friday': ['Tea'],
                  //   'Sunday': ['Coffee', 'Pav Bhaji'],
                  //   'Wednesday': ['Tea'],
                  //   'Tuesday': ['Coffee', 'Hot Milk'],
                  //   'Saturday': ['Coffee']
                  // };
                  docData[widget.selectedDay] = updatedList;
                  print(docData.toString());
                  docRef.update({widget.mealOfDay: docData});
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Suggestion {
  List<String> breakfastSuggestion;
  List<String> lunchSuggestion;
  List<String> hiTeaSuggestion;
  List<String> dinnerSuggestion;
  Suggestion();
}
