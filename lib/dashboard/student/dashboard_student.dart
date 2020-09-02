import 'package:flutter/material.dart';
import 'package:hostel_app/form/outPass_form.dart';
import 'package:hostel_app/login/loginScreen.dart';
import 'package:hostel_app/model/studentModel.dart';

class DashboardStudent extends StatelessWidget {
  final titles = [
    'Apply for OutPass',
    'Mess Menu',
    'Service Request',
    'Laundry Cycles'
  ];
  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.local_dining),
    Icon(Icons.settings),
    Icon(Icons.local_laundry_service)
  ];
  var studentObject = StudentField.inintalize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Welcome " + studentObject.studentName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text('Logout'),
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ],
              ),
              Divider(
                thickness: 0.7,
                color: Colors.white70,
              ),
              Flexible(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: titles.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                        ),
                        //color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              titleIcon[index],
                              Text(
                                titles[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OutpassForm()),
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'View OutPass Status',
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
