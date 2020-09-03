import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hostel_app/dashboard/hostel_InCharge/dashboard_warden.dart';
import 'package:hostel_app/theme/theme.dart';
import 'notificationmodel.dart';

class Approvals extends StatefulWidget {
  Approvals({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApprovalsState createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkerBlue,
          title: Text("Outpass Request",
          style: lightHeading,),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashboardHostelInCharge()),
                );
              })),
      body: Container(
        child: ListView.builder(
          itemCount: ApprovalModel.dummyData.length,
          itemBuilder: (context, index) {
            ApprovalModel _model = ApprovalModel.dummyData[index];
            return Column(
              children: <Widget>[
                Divider(
                  height: 12.0,
                ),
                StudentTile(model: _model)
              ],
            );
          },
        ),
      ),
    );
  }
}

class StudentTile extends StatefulWidget {
  const StudentTile({
    Key key,
    @required ApprovalModel model,
  })  : _model = model,
        super(key: key);

  final ApprovalModel _model;

  @override
  _StudentTileState createState() => _StudentTileState();
}

class _StudentTileState extends State<StudentTile> {
  TextEditingController customController = TextEditingController();
  bool talkedToParent = false;
  String remarks;
  bool approved = false;
  bool read = false;

  Future<String> createAlertDialog(
      {BuildContext context,
      String studentName,
      String registrationNo,
      String requestID,
      String batch,
      String course,
      String roomNo,
      String reason,
      String destination,
      String parentContactNumber,
      /*bool talkedToParent ,*/ String startDate,
      String endDate /*String remarks,bool approve=false*/,
      String transport}) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.all(5),
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        studentName,
                        style: requestCardHeading
                      ),
                    ),
                    Column(
                      children: [
                        Text('Registration Number: $registrationNo',
                            style: kCardTextStyle),
                        Text('Course: $course', style: kCardTextStyle),
                        Text('Batch: $batch', style: kCardTextStyle),
                        Text('Room No: $roomNo', style: kCardTextStyle),
                        Text('Request ID: $requestID', style: kCardTextStyle),
                        Text(
                          'Reason: $reason',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text('Start Date: $startDate', style: kCardTextStyle),
                        Text('End Date: $endDate', style: kCardTextStyle),
                        Text('Destination: $destination',
                            style: kCardTextStyle),
                        Text('Transport: $transport', style: kCardTextStyle),
                        Text('Contact Number Of Parent: $parentContactNumber',
                            style: kCardTextStyle),
                        StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return CardInput(
                              toggleCheckBoxState: (bool value) {
                                setState(() {
                                  talkedToParent = value;
                                });
                              },
                              controller: customController,
                              checkBoxState: talkedToParent,
                              approved: approved,
                              approvedButtonState: () {
                                setState(() {
                                  approved = true;
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);
                                  approved == true
                                      ? print('Approved!')
                                      : print('Rejected');
                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },
                              rejectedButtonState: () {
                                setState(() {
                                  remarks = customController.text;
                                  print(talkedToParent);
                                  print(remarks);
                                  approved == true
                                      ? print('Approved!')
                                      : print('Rejected');
                                  Navigator.of(context)
                                      .pop(customController.text.toString());
                                });
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          read = true;
          createAlertDialog(
              context: context,
              studentName: widget._model.studentName,
              registrationNo: widget._model.registrationNo,
              requestID: widget._model.requestID,
              batch: widget._model.batch,
              course: widget._model.course,
              roomNo: widget._model.roomNo,
              reason: widget._model.reason,
              destination: widget._model.destination,
              parentContactNumber: widget._model.parentContactNumber,
              /* talkedToParent: _model.talkedToParent,*/
              startDate: widget._model.startDate,
              endDate: widget._model.endDate,
              transport: widget._model
                  .transport /*remarks: _model.remarks, approve: _model.approve*/);
        });
      },
      leading: CircleAvatar(
        radius: 24.0,
        backgroundImage: AssetImage("assets/food.png"),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget._model.studentName,style: darkSmallTextBold,),
          Text(
            widget._model.startDate,
            style: darkTinyText
          ),
        ],
      ),
      subtitle: Text(" Request ID: ${widget._model.requestID}",style: greySmallText,),
      trailing: CircleAvatar(
          radius: 5.0,
          backgroundColor: read == false ? Colors.red : Colors.white),
    );
  }
}

class CardInput extends StatelessWidget {
  final bool checkBoxState;
  final String remarks;
  final bool approved;
  final Function toggleCheckBoxState;
  final Function approvedButtonState;
  final Function rejectedButtonState;
  final TextEditingController controller;

  CardInput(
      {this.checkBoxState,
      this.toggleCheckBoxState,
      this.controller,
      this.approved,
      this.approvedButtonState,
      this.rejectedButtonState,
      this.remarks});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Talked To Parents: ", style: kCardTextStyle),
              SizedBox(
                width: 10,
              ),
              Checkbox(
                activeColor: Colors.blue[600],
                value: checkBoxState,
                onChanged: (toggleCheckBoxState),
              ),
            ],
          ),
          TextField(
              controller: controller,
              decoration: kTextFieldDecoration.copyWith(labelText: 'Remarks')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.white,
                    child: Text(
                      'Reject',
                      style: kbuttonTextStyle
                    ),
                    onPressed: rejectedButtonState),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: MaterialButton(
                    textColor: Colors.white,
                    child: Text(
                      'Approve',
                      style: kbuttonTextStyle
                    ),
                    onPressed: approvedButtonState),
              )
            ],
          )
        ],
      ),
    );
  }
}
