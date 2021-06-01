import 'package:flutter/material.dart';
import 'package:hostel_app/theme/theme.dart';
import '../../../common/bottomBar/navigationBarHostel.dart';
import 'package:hostel_app/function/adminHandle/hostelAdmin/updateInfo/updateHostelEmployee.dart';
import 'package:hostel_app/function/adminHandle/hostelAdmin/updateInfo/updateStudent.dart';

class UpdateInfo extends StatefulWidget {
  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
  int cycles;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: darkerBlue,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HostelBar()),
                    );
                  },
                );
              },
            ),
            bottom: TabBar(
              indicatorColor: peach,
              indicatorWeight: 4,
              labelStyle: lightTinyText.copyWith(fontWeight: FontWeight.bold),
              tabs: [
                Tab(
                  text: 'Student',
                ),
                Tab(
                  text: 'Hostel Employee',
                ),
              ],
            ),
            title: Text(
              'Update Information  ',
              style: lightSmallText.copyWith(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              UpdateStudent(),
              UpdateEmployee(),

            ],
          ),
        ),
      ),
    );
  }
}
