import 'package:flutter/material.dart';

class FoodItemList extends StatelessWidget{
  final String item1, item2, item3;
  const FoodItemList(this.item1, this.item2, this.item3); 
  @override 
  Widget build(BuildContext context){
    return Container(
      child: Row(    
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          OutlinedButton(
            onPressed: (){}, 
            child: Text(item1),
            style: OutlinedButton.styleFrom(
              onSurface: Colors.black,
              primary: Colors.black,
              minimumSize: Size(100,100),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          OutlinedButton(
            onPressed: (){}, 
            child: Text(item2),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              minimumSize: Size(100,100),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
          SizedBox(width: 5.0,),
          OutlinedButton(
            onPressed: (){}, 
            child: Text(item3),
            style: OutlinedButton.styleFrom(
              onSurface: Colors.black,
              primary: Colors.black,
              minimumSize: Size(100,100),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
            ),
          ),
        ],
      ),
    );   
  } 
}