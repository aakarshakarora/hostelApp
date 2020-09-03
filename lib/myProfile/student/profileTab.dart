import 'package:flutter/material.dart';
import 'package:hostel_app/model/studentModel.dart';
import 'package:hostel_app/theme/theme.dart';
class UserDetail extends StatelessWidget {
  var studentObject = StudentField.inintalize();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Course Name: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(studentObject.courseName,
                    style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Registration Number: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(studentObject.registrationNumber.toString(),
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Contact Number: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(studentObject.contactNumber.toString(),
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Personal Email ID: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(studentObject.personalEmailID,
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "College Email ID: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(studentObject.collegeEmailID,
                      style: darkSmallText,),
                  ],
                )
              ],
            ),
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
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Parent Name: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(parentObject.parentName,
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Parent Contact Number: ",
                      style:
                      darkSmallTextBold
                    ),
                    Text(parentObject.parentContactNumber.toString(),
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Parent Email ID: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(parentObject.parentEmailID,
                      style: darkSmallText,),
                  ],
                ),
              ],
            ),
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
          body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "Mentor Name: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(mentorObject.mentorName,
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Mentor Contact Number: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(mentorObject.mentorContactNumber.toString(),
                      style: darkSmallText,),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Mentor Email ID: ",
                      style:
                      darkSmallTextBold,
                    ),
                    Text(mentorObject.mentorEmailID,
                      style: darkSmallText,),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
