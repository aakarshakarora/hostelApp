import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/function/mess/addFoodItem.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working fine
class AddMenuItem extends StatefulWidget {
  String mealOfDay;

  AddMenuItem({this.mealOfDay});

  @override
  _AddMenuItemState createState() => _AddMenuItemState();
}

class _AddMenuItemState extends State<AddMenuItem> {
  final messController = TextEditingController();
  List<String> _brekfastSelected;
  List<String> _lunchSelected;
  List<String> _hiTeaSelected;
  List<String> _dinnerSelected;
  List<String> breakfastSuggestion = [
    "Tea",
    "Coffee",
    "Hot Milk",
    "Pav Bhaji",
    "Dosa",
    "Idli",
    "Vada",
    "Utpam",
    "Upma",
    "Sambhar",
    "Poha",
    "Pasta",
    "Noodles",
    "Allo Prantha",
    "Curd",
    "Tomato Chutney",
    "Chole Bhature",
    "Poori Bhaji",
    "Bread",
    "Jam",
    "Butter",
    "Fruits",
    "Egg"
  ];
  List<String> lunchSuggestion = [
    "Rice",
    "Chapati",
    "Kofta",
    "Papad",
    "Fryums",
    "Lassi",
    "Pickle",
    "Green Salad",
    "Aloo Ki Sabzi",
    "Bhindi do Pyaaz",
    "Rajma",
    "Kadi Pakoda",
    "Pindi Chole",
    "Black Chana",
    "Chawli Masala",
    "Dal Fry",
    "Toor Dal",
    "Dal Mysore",
    "Soya Chap",
    "Mix Veg"
  ];
  List<String> hiTeaSuggestion = [
    "Tea",
    "Coffee",
    "Samosa",
    "Allo Onion Kachori",
    "Paani-Puri",
    "Pizza",
    "Pasta",
    "Noodles",
    "Veg Puff",
    "Bhel",
    "Dhokha",
    "Aloo Bhonda",
    "Vada Pav",
    "Fried Idli",
    "Daal Kachori",
    "Doughnut",
    "Allo Tikki",
    "Maggi",
    "Potato Veg",
    "Veg Sandwich",
    "Mix Veg Pakoda"
  ];
  List<String> dinnerSuggestion = [
    "Kadai paneer",
    "Paneer",
    "Malai Kofta",
    "Rajma",
    "Chapati",
    "Custard",
    "Gulab Jamun",
    "Shahi Bread",
    "Fried Rice"
  ];

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
    _brekfastSelected = <String>[];
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
                  kTextFieldDecoration.copyWith(labelText: 'Enter Food Item'),
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
            FoodItemList(
                foodItems: widget.mealOfDay == 'breakfast'
                    ? breakfastSuggestion
                    : widget.mealOfDay == 'lunch'
                        ? lunchSuggestion
                        : widget.mealOfDay == 'hiTea'
                            ? hiTeaSuggestion
                            : dinnerSuggestion,
            foodItemsSelected:widget.mealOfDay == 'breakfast'
                ? _brekfastSelected
                : widget.mealOfDay == 'lunch'
                ? _lunchSelected
                : widget.mealOfDay == 'hiTea'
                ? _hiTeaSelected
                : _dinnerSelected, ),
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
                  docRef.update({
                    widget.mealOfDay:
                        FieldValue.arrayUnion([messController.text])
                  });
                  print(widget.mealOfDay == 'breakfast'
                      ? _brekfastSelected
                      : widget.mealOfDay == 'lunch'
                      ? _lunchSelected
                      : widget.mealOfDay == 'hiTea'
                      ? _hiTeaSelected
                      : _dinnerSelected);
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
