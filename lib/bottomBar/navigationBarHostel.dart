import 'package:flutter/material.dart';
import 'package:hostel_app/Notification/notification.dart';
import 'package:hostel_app/dashboard/hostel_InCharge/dashboard_warden.dart';
import 'package:hostel_app/myProfile/hostel_InCharge/hostelProfile.dart';
import 'package:hostel_app/theme/theme.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HostelBar extends StatefulWidget {
  HostelBar({Key key}) : super(key: key);

  @override
  _HostelBarState createState() => _HostelBarState();
}

class _HostelBarState extends State<HostelBar> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [DashboardHostelInCharge(), Notifications(), ProfileHostel()];
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
        title: ("Notifications "),
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
