import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostel_app/function/spashScreen/roleCheck.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'HomeScreen App',
              home: RoleCheck(),
              // home: NotVerified()
            );
          },
        );
      },
    );
  }
}
