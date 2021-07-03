import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';

//Status : Working fine
//This is the food items list which is fetched from firebase and is displayed in the messupdate section for the mess manager
class MasterFoodItemsList extends StatelessWidget {
  final String mealOfDay;
  final String documentName;
  MasterFoodItemsList({this.mealOfDay,this.documentName});

  @override
  Widget build(BuildContext context) {
    print(mealOfDay);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("messMenu").doc("EzkkLnYtQPbSDLxMToZm").collection("MessMenu").doc(documentName).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();
        return Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      child: snapshot.data[mealOfDay]!=
                          null
                          ? Column(
                        children: [
                          for (var foodName in snapshot.data[mealOfDay])
                            Card(
                              elevation: 4,
                              child: ListTile(
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      DocumentReference docRef =
                                      FirebaseFirestore.instance
                                          .collection('messMenu')
                                          .doc(
                                          'EzkkLnYtQPbSDLxMToZm').collection("MessMenu").doc(documentName);
                                      DocumentSnapshot doc =
                                      await docRef.get();
                                      List<dynamic> tags =
                                      doc.data()[mealOfDay];
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
                                      child: Text(
                                        foodName.toString(),
                                        style: darkSmallText.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ),
                        ],
                      )
                          : Container(
                        height: 100,
                        color: Colors.black,
                      ));
                }));
      },
    );
  }
}
