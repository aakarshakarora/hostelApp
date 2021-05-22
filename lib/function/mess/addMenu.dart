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
  @override           
  Widget build(BuildContext context) {
    String newFoodTitle;
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
        ),
        child: Column(    
          children: [
            Text("Add Food Item",
              style: darkHeading,),
            SizedBox(height: 20,),

            // TextFormField --------------------------
            TextFormField(
              controller: messController,
              decoration: kTextFieldDecoration.copyWith(labelText: 'Enter Food Item'),
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
            SizedBox(height: 10.0,),
            // -----------------------------------
            
            // ----- Something New ---------------
            FoodItemList('Item One', 'Item Two','Item Three'),
            SizedBox(height: 20.0,),
            FoodItemList('Item Four', 'Item Five', 'Item Six'),
            // -----------------------------------
            SizedBox(height: 10,),                            
            Container(
              decoration: kloginScreenButtonStyle.copyWith(
                  color: peach
              ),
              child: FlatButton(
                child: Text("Add",
                  style: kbuttonTextStyle,),
                onPressed: () async {
                  print(newFoodTitle);
                  DocumentReference docRef = FirebaseFirestore.instance.collection('messMenu').doc('EzkkLnYtQPbSDLxMToZm');
                  DocumentSnapshot doc = await docRef.get();
                  docRef.update(
                      {widget.mealOfDay :FieldValue.arrayUnion([messController.text])}
                  );

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

