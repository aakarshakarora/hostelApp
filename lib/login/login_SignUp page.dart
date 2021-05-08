import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/login/login.dart';

import 'package:hostel_app/login/register/registerStudent.dart';
import 'package:hostel_app/login/register/registerUser.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: Working Fine

/*
Login and Sign Up Button
*/

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey _key = LabeledGlobalKey("button_icon");
  OverlayEntry _overlayEntry;
  Size buttonSize;
  Offset buttonPosition;
  bool isMenuOpen = false;
  String text = 'Sign Up';

  List<Text> type = [
    Text(
      'Student',
      style: lightTinyText.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      'Hostel Employee',
      style: lightTinyText.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: buttonPosition.dx,
          width: buttonSize.width,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 17,
                      height: 17,
                      color: peach,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: peach,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        type.length,
                        (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                text = 'Sign Up';
                              });
                              print(index);
                              switch (index) {
                                case 0:
                                  print('selected 0');

                                  closeMenu();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => StudentRegister(),
                                    ),
                                  );
                                  break;
                                case 1:
                                  print('selected 1');
                                  closeMenu();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HostelUser(),
                                    ),
                                  );
                                  break;
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: buttonSize.width,
                              height: buttonSize.height,
                              child: type[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void openMenu() {
    findButton();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  void closeMenu() {
    _overlayEntry.remove();
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkerBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: kloginScreenButtonStyle,
              child: FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  if (isMenuOpen) closeMenu();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                child: Text(
                  "Login",
                  style: lightHeading,
                ),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Container(
              key: _key,
              width: 200,
              decoration: kloginScreenButtonStyle,
              child: FlatButton(
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  if (isMenuOpen) {
                    setState(() {
                      text = 'Sign Up';
                    });
                    closeMenu();
                  } else {
                    setState(() {
                      text = 'Sign Up As...';
                    });
                    openMenu();
                  }
                },
                child: Text(
                  text,
                  style: lightHeading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
