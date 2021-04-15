import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status : Working fine
//This is the food items list which is fetched from firebase and is displayed in the messupdate section for the mess manager
class FoodItemsList extends StatelessWidget {

  String mealOfDay;
  FoodItemsList({this.mealOfDay});

  var firestoreDB =
  FirebaseFirestore.instance.collection("messMenu").snapshots();

  @override
  Widget build(BuildContext context) {
    print(mealOfDay);
    return StreamBuilder(
      stream: firestoreDB,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index){

                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: Column(
                        children: [
                          for (var foodName in snapshot.data.documents[index]
                              .get(mealOfDay))
                            Card(
                              elevation: 4,
                              child: ListTile(
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async{
                                      DocumentReference docRef = FirebaseFirestore.instance.collection('messMenu').doc('EzkkLnYtQPbSDLxMToZm');
                                      DocumentSnapshot doc = await docRef.get();
                                      List tags = doc.data()[mealOfDay];
                                      if(tags.contains(foodName)==true){
                                        docRef.update(
                                            {mealOfDay :FieldValue.arrayRemove([foodName])}
                                        );
                                      }
                                      else{
                                        docRef.update(
                                            {mealOfDay :FieldValue.arrayUnion([foodName])}
                                        );
                                      }

                                    },
                                  ),
                                  title: Container(
                                      child: Text(foodName.toString(),
                                        style: darkSmallText.copyWith(fontSize: 16,fontWeight: FontWeight.bold),))),
                            ),
                        ],
                      )
                  );
                }
            )
        );
      },

    );
  }
}