import 'package:flutter/material.dart';
import 'package:hostel_app/model/studentModel.dart';
import 'profileTab.dart';
import 'package:hostel_app/theme/theme.dart';

class ProfileStudent extends StatelessWidget {
  var studentObject = StudentField.inintalize();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // Added
      length: 3, // Added
      initialIndex: 0, //Added
      child: Scaffold(
        backgroundColor: white,
        body: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              color: darkerBlue,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 3, top: 50),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/profile.jpg"))),
                        ),
                        SizedBox(width: 50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              studentObject.studentName,
                              style: lightHeading
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.airline_seat_individual_suite,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      studentObject.block +
                                          studentObject.roomNumber.toString(),
                                      style: lightTinyText
                                    ),
                                  ],
                                ),
                                SizedBox(width: 12),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.airline_seat_individual_suite,
                                      color: Colors.white,
                                      size: 24.0,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      studentObject.occupancyType,
                                      style: lightTinyText
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              studentObject.courseName,
                              style: lightSmallText
                            ),
                            Text(
                              "Program",
                              style: lightTinyText
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              studentObject.registrationNumber.toString(),
                              style: lightSmallText
                            ),
                            Text(
                              "Registration Number",
                              style: lightTinyText
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: peach),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "EDIT PROFILE",
                              style: TextStyle(
                                color: peach,
                                fontSize: 12,
                                fontFamily: 'Poppins'
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 230),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    )),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30.0, top: 20),
                      child: Text(
                        "User Information",
                        style: darkHeading
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      child: TabBar(
                        indicatorColor: peach,
                        tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "User Details",
                                style: darkSmallTextBold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Parent Details",
                                style: darkSmallTextBold,
                              ),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Mentor Details",
                                style: darkSmallTextBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: Container(
                          child: TabBarView(
                            children: [
                              UserDetail(),
                              ParentDetail(),
                              MentorDetail(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
