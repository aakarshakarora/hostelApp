import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class FoodItemList extends StatefulWidget {
  final List<String> foodItems,foodItemsSelected;
  const FoodItemList({this.foodItems,this.foodItemsSelected});

  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
          itemCount: widget.foodItems.length,
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
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                onTap: () {
                  print(widget.foodItems[index]);
                },
                child: FilterChip(
                  padding: EdgeInsets.all(3.5),
                  avatar: CircleAvatar(
                    backgroundColor: peach,
                    child: Text(
                      widget.foodItems[index][0].toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  elevation: 5,
                  shadowColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  label: Text(
                    widget.foodItems[index],
                    // foodItems[index].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  backgroundColor: Colors.blue[500],
                  selectedColor: Colors.orange,
                  selected: widget.foodItemsSelected.contains(widget.foodItems[index]),
                  onSelected: (bool selected){
                    setState(() {
                      if(selected){
                        widget.foodItemsSelected.add(widget.foodItems[index]);
                      }
                      else {
                        widget.foodItemsSelected.removeWhere((String name){
                          return name == widget.foodItems[index];
                        });
                      }
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
