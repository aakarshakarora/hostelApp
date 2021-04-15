import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/common/Notification/notification.dart';
import 'package:hostel_app/view/dashboard/hostel_InCharge/dashboard_warden.dart';
import 'package:hostel_app/view/myProfile/hostel_InCharge/hostelProfile.dart';

//Status: No changes Required

/*
Bottom Navigation Bar for Hostel In Charge Page
1. Home 2. Notification 3. My Profile
*/

class HostelBar extends StatefulWidget {
  HostelBar({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HostelBarState createState() => _HostelBarState();
}

class _HostelBarState extends State<HostelBar> with AutomaticKeepAliveClientMixin<HostelBar>
{
  @override
  bool get wantKeepAlive => true;

  int currentPage;
  Color currentColor = Colors.deepPurple;
  Color inactiveColor = Colors.black;
  PageController tabBarController;
  List<Tabs> tabs = new List();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    currentPage = 0;
    tabs.add(Tabs(
        Icons.home, "Home", Colors.deepPurple, getGradient(Colors.deepPurple)));
    tabs.add(Tabs(Icons.notifications, "Notifications", Colors.deepPurple,
        getGradient(Colors.deepPurple)));
    tabs.add(Tabs(Icons.account_circle, "Profile", Colors.deepPurple,
        getGradient(Colors.deepPurple)));
    tabBarController = new PageController(initialPage: 0);
  }

  @override
    Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PageView(
          controller: tabBarController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            DashboardHostelInCharge(),
            Notifications(),
            ProfileHostel(),
          ]),
      bottomNavigationBar: CubertoBottomBar(
        key: Key("BottomBar"),
        inactiveIconColor: inactiveColor,
        tabStyle: CubertoTabStyle.STYLE_FADED_BACKGROUND,
        selectedTab: currentPage,
        tabs: tabs
            .map((value) => TabData(
                key: Key(value.title),
                iconData: value.icon,
                title: value.title,
                tabColor: value.color,
                tabGradient: value.gradient))
            .toList(),
        onTabChangedListener: (position, title, color) {
          setState(() {
            currentPage = position;
            tabBarController.jumpToPage(position);
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }
}

class Tabs {
  final IconData icon;
  final String title;
  final Color color;
  final Gradient gradient;

  Tabs(this.icon, this.title, this.color, this.gradient);
}

getGradient(Color color) {
  return LinearGradient(
      colors: [color.withOpacity(0.5), color.withOpacity(0.1)],
      stops: [0.0, 0.7]);
}
