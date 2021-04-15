import 'package:flutter/material.dart';
import 'package:hostel_app/model/notificationModel.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Feature to be Implemented
/*
Notification Display [Dummy]
*/
class Notifications extends StatefulWidget {
  Notifications({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: NotificationModel.dummyData.length,
          itemBuilder: (context, index) {
            NotificationModel _model = NotificationModel.dummyData[index];
            return Column(
              children: <Widget>[
                Divider(
                  height: 12.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 21.0,
                    backgroundImage: AssetImage("assets/food.png"),
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        _model.title,
                        style: darkSmallTextBold,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        _model.dateString,
                        style: darkTinyText,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    _model.subheading,
                    style: greySmallText,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14.0,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
