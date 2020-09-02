import 'package:flutter/material.dart';
import 'package:hostel_app/model/studentModel.dart';

class UserDetail extends StatelessWidget {
  var studentObject = StudentField.inintalize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Course Name: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(studentObject.courseName),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Registration Number: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(studentObject.registrationNumber.toString()),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Contact Number: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(studentObject.contactNumber.toString()),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Personal Email ID: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(studentObject.personalEmailID),
                ],
              ),
              Row(
                children: [
                  Text(
                    "College Email ID: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(studentObject.collegeEmailID),
                ],
              )
            ],
          ),
        ));
  }
}

class ParentDetail extends StatelessWidget {
  var parentObject = ParentField.inintalize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Parent Name: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(parentObject.parentName),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Parent Contact Number: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(parentObject.parentContactNumber.toString()),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Parent Email ID: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(parentObject.parentEmailID),
                ],
              ),
            ],
          ),
        ));
  }
}

class MentorDetail extends StatelessWidget {
  var mentorObject = MentorField.inintalize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Mentor Name: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(mentorObject.mentorName),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Mentor Contact Number: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(mentorObject.mentorContactNumber.toString()),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Mentor Email ID: ",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(mentorObject.mentorEmailID),
                ],
              ),
            ],
          ),
        ));
  }
}
