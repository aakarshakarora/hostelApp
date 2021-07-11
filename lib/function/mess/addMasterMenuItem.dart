import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//This is the bottomsheet which pops up when the Add menu button '+' is pressed.
//Status: Working fine
class AddMasterMenuItem extends StatefulWidget {

  String mealOfDay;
  String documentName;
  AddMasterMenuItem({this.mealOfDay,this.documentName});

  @override
  _AddMasterMenuItemState createState() => _AddMasterMenuItemState();
}

class _AddMasterMenuItemState extends State<AddMasterMenuItem> {
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
            SizedBox(height: 20,),
            Container(
              decoration: kloginScreenButtonStyle.copyWith(
                  color: peach
              ),
              child: FlatButton(
                child: Text("Add",
                  style: kbuttonTextStyle,),
                onPressed: () async {
                  print(newFoodTitle);
                  DocumentReference docRef = FirebaseFirestore.instance.collection('messMenu').doc('EzkkLnYtQPbSDLxMToZm').collection("MessMenu").doc(widget.documentName);
                  DocumentSnapshot doc = await docRef.get();
                  docRef.update(
                      {widget.mealOfDay :FieldValue.arrayUnion([messController.text])}
                  );
                  print(messController.text);
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
