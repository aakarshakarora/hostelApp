import 'package:flutter/material.dart';
import 'package:hostel_app/form/Guest%20Room/roomBookForm.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Select Room Type for Guest Room Booking
*/

class RoomTypes extends StatefulWidget {
  @override
  _RoomTypesState createState() => _RoomTypesState();
}

class _RoomTypesState extends State<RoomTypes> {
  bool press = false;

  Widget info() {
    if (press == true) {
      return Container(
          padding: EdgeInsets.all(10),
          color: Colors.yellowAccent,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.info),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  'Note: Each room can occupy maximum of 2 adults.\nFor any queries, contact : muj.guesthouse@jaipur.manipal.edu\nMr. Ganesh +91-7728885754',
                  style: darkSmallTextBold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    press = false;
                  });
                },
              )
            ],
          ));
    } else {
      return Container(
        height: 0,
      );
    }
  }

  final roomTypes = ['Student', 'Standard', 'Executive'];
  final prices = [920.0, 1200.0, 1600.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkerBlue,
        centerTitle: true,
        title: Text(
          'Rooms',
          style: lightHeading,
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                setState(() {
                  press = true;
                });
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
        child: Column(
          children: [
            info(),
            Expanded(
              child: ListView.builder(
                itemCount: roomTypes.length,
                itemBuilder: (ctx, index) => RoomCard(
                  roomType: roomTypes[index],
                  price: prices[index],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Status: Working Fine

/*
Room Type in Details for Guest Room Booking
*/

class RoomCard extends StatelessWidget {
  RoomCard({this.roomType, this.price});

  final String roomType;
  final double price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => RoomBook(roomType)));
      },
      child: Container(
        height: 350,
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: white,
          elevation: 4,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                  color: darkerBlue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/room.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: peach,
                    width: 2,
                  ),
                ),
                child: Text(
                  roomType,
                  style: darkHeading,
                ),
              ),
              Divider(
                thickness: 0.8,
                color: darkBlue,
              ),
              Text(
                '₹ $price for 24 Hours',
                style: darkHeading,
              ),
              Text(
                'Amenities included :',
                style: darkSmallTextBold,
              ),
              Text(
                'Double Bed, Air Conditioner, TV, Geyser, Fridge',
                style: darkSmallText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
