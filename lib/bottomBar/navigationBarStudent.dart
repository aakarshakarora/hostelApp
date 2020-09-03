import 'package:flutter/material.dart';
import 'package:hostel_app/Notification/notification.dart';
import 'package:hostel_app/dashboard/student/dashboard_student.dart';

import 'package:hostel_app/myProfile/student/studentProfile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:hostel_app/theme/theme.dart';

class StudentBar extends StatefulWidget {
  StudentBar({Key key}) : super(key: key);

  @override
  _StudentBarState createState() => _StudentBarState();
}

class _StudentBarState extends State<StudentBar> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [DashboardStudent(), Notifications(), ProfileStudent()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColor: darkBlue,
        inactiveColor: Colors.grey,
        //isTranslucent: false,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications),
        title: ("Notifications  "),
        activeColor: darkBlue,
        inactiveColor: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.account_circle),
        title: ("Profile"),
        activeColor: darkBlue,
        inactiveColor: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      items: _navBarsItems(),
      screens: _buildScreens(),
      //showElevation: false,
      //navBarCurve: NavBarCurve.none,
      backgroundColor: const Color(0xFFEBEEF1),
      iconSize: 26.0,
      navBarStyle: NavBarStyle.style8,
      // Choose the nav bar style with this property
      onItemSelected: (index) {
        print(index);
      },
    );
  }
}
