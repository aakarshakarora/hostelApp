import 'package:flutter/material.dart';
import 'package:hostel_app/form/OutPass/outPassRequest/daypass_approval.dart';

import '../../../form/OutPass/outPassRequest/outpass_approval.dart';
import '../../../theme/theme.dart';

//Status: Working fine
//OutpassCardUpdate is called when approve/reject buttons are pressed
class OutPassCardUpdate extends StatelessWidget {
  final bool checkBoxState;
  final String remarks;
  final String approved;
  final bool read;
  final Function toggleCheckBoxState;
  final Function approvedButtonState;
  final Function rejectedButtonState;
  final TextEditingController controller;
  final String passType;

  // ignore: non_constant_identifier_names
  //For rejecting the outpass request
  Widget RejectedButton() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: MaterialButton(
          textColor: Colors.white,
          child: Text('Reject', style: kbuttonTextStyle),
          onPressed: rejectedButtonState),
    );
  }

  // ignore: non_constant_identifier_names
  //For approving the outpass request
  Widget ApprovedButton() {
    return Container(
      margin: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: MaterialButton(
          textColor: Colors.white,
          child: Text('Approve', style: kbuttonTextStyle),
          onPressed: approvedButtonState),
    );
  }

  //Handles the layout of Approve and Reject Button on The basis of Request Status
  // ignore: non_constant_identifier_names, missing_return
  Widget Submit() {
    if (passType == 'OutPass') {
      if (Approvals.approvalStatus == 'Pending') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RejectedButton(),
            ApprovedButton(),
          ],
        );
      } else if (Approvals.approvalStatus == 'Rejected') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ApprovedButton(),
          ],
        );
      } else if (Approvals.approvalStatus == 'Approved' ||
          Approvals.approvalStatus == 'Processing') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RejectedButton(),
          ],
        );
      }
    } else {
      if (DayPassApprovals.approvalStatus == 'Pending') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RejectedButton(),
            ApprovedButton(),
          ],
        );
      } else if (DayPassApprovals.approvalStatus == 'Rejected') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ApprovedButton(),
          ],
        );
      } else if (DayPassApprovals.approvalStatus == 'Approved' ||
          DayPassApprovals.approvalStatus == 'Processing') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RejectedButton(),
          ],
        );
      }
    }
  }

  OutPassCardUpdate(
      {this.checkBoxState,
      this.toggleCheckBoxState,
      this.controller,
      this.approved,
      this.approvedButtonState,
      this.rejectedButtonState,
      this.remarks,
      this.read,
      this.passType});

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
          Submit(),
        ],
      ),
    );
  }
}
