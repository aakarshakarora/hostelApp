import 'package:flutter/material.dart';

class DashboardWarden extends StatelessWidget {
  final titles = [
    'OutPass Requests','Service Requests'
  ];
  final titleIcon = [
    Icon(Icons.assignment),
    Icon(Icons.settings),

  ];
  final name = 'Warden';
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
                    'Welcome, $name!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  FlatButton.icon(
                    onPressed: () {},
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
                      onTap: () {},
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
