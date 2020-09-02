import 'package:flutter/material.dart';
import 'package:hostel_app/login/loginScreen.dart';
import 'package:hostel_app/model/hostelInChargeModel.dart';
import 'package:hostel_app/outPassRequest/outpass_approval.dart';

class DashboardHostelInCharge extends StatelessWidget {
  final titles = ['OutPass Requests', 'Service Requests'];
  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.settings),
  ];
  var hostelObject = HostelInChargeField.initialize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Welcome ' + hostelObject.userNameHostel,
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
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
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
                        child: Container(
                          height: 100,
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
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Approvals()),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
