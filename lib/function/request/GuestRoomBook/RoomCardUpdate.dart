import 'package:flutter/material.dart';
import 'package:hostel_app/form/Guest Room/roomBookApproval.dart';
import 'package:hostel_app/theme/theme.dart';

//Status: working fine
//RoomCardUpdate is called when the Approve/Reject buttons are pressed

class RoomCardUpdate extends StatelessWidget {
  final bool checkBoxState;
  final String remarks;
  final String approved;
  final bool read;
  final Function approvedButtonState;
  final Function rejectedButtonState;
  final TextEditingController controller;

// ignore: missing_return, non_constant_identifier_names
  //This buttons is for Rejecting the request
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
// ignore: missing_return, non_constant_identifier_names
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

  // ignore: missing_return, non_constant_identifier_names
  Widget Submit() {
    if (RoomApproval.roomStatus == 'Pending') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RejectedButton(),
          ApprovedButton(),
        ],
      );
    } else if (RoomApproval.roomStatus == 'Rejected') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ApprovedButton(),
        ],
      );
    } else if (RoomApproval.roomStatus == 'Approved') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RejectedButton(),
        ],
      );
    }
  }

  RoomCardUpdate(
      {this.checkBoxState,
        this.controller,
        this.approved,
        this.approvedButtonState,
        this.rejectedButtonState,
        this.remarks,
        this.read});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
              controller: controller,
              decoration: kTextFieldDecoration.copyWith(labelText: 'Remarks')),
          Submit(),
        ],
      ),
    );
  }
}