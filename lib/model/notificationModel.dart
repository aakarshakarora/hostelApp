import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

class NotificationModel {
  String title;
  String subheading;
  String dateString = dateFormat.format(DateTime.now());
  bool markAsRead;

  NotificationModel(
      {this.title, this.subheading, this.dateString, this.markAsRead});

  static final List<NotificationModel> dummyData = [
    NotificationModel(
      title: "Welcome Dinner",
      subheading: "Special Dinner for Hosteler",
      dateString: dateFormat.format(DateTime.now()),
      markAsRead: true,
    ),
    NotificationModel(
      title: "Welcome Dinner",
      subheading: "Special Dinner for Hosteler",
      dateString: dateFormat.format(DateTime.now()),
      markAsRead: true,
    ),
    NotificationModel(
      title: "Welcome Dinner",
      subheading: "Special Dinner for Hosteler",
      dateString: dateFormat.format(DateTime.now()),
      markAsRead: true,
    )
  ];
}
