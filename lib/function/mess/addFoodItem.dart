import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class FoodItemList extends StatelessWidget {
  final List<String> foodItems;
  const FoodItemList({this.foodItems});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        radius: Radius.circular(5),
        thumbColor: darkBlue,
        thickness: 5,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          physics: AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: foodItems.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            // return Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     color: Colors.blue,
            //     height: 10,
            //     //width: 10,
            //   ),
            // );
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: InkWell(
                onTap: () {
                  print(foodItems[index]);
                },
                child: InputChip(
                  backgroundColor: Colors.orange,
                  selectedColor: Colors.blue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  label: Text(foodItems[index],style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'
                  ),),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
