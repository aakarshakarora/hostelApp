import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Constants.dart';

class OutpassForm extends StatefulWidget {
  @override
  _OutpassFormState createState() => _OutpassFormState();
}

class _OutpassFormState extends State<OutpassForm> {
  String _Destination;
  String _Reason;
  DateTime _startDate;
  DateTime _endDate;
  String _MentorEmail;
  String _MentorContactNum;
  DateTime _starttime;
  DateTime _endTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDestinationField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        decoration: kTextFieldDecoration.copyWith(
            labelText: 'Enter Destination Address:'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Address is required';
          }
        },
        onSaved: (String value) {
          _Destination = value;
        },
      ),
    );
  }

  Widget _buildReasonField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        decoration: kTextFieldDecoration.copyWith(labelText: 'Enter a reason:'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Reason is required';
          }
        },
        onSaved: (String value) {
          _Reason = value;
        },
      ),
    );
  }

  Widget _buildMentorEmailField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: kTextFieldDecoration.copyWith(
            labelText: "Enter  Mentor's Email Id (Optional)"),
        validator: (String value) {
          if (value == '') {
            return null;
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        },
        onSaved: (String value) {
          _MentorEmail = value;
        },
      ),
    );
  }

  Widget _buildMentorContactNumField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.number,
        decoration: kTextFieldDecoration.copyWith(
            labelText: "Enter Mentor's Contact Number (Optional)"),
        // ignore: missing_return
        onSaved: (String value) {
          _MentorContactNum = value;
        },
      ),
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Outpass Form',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildReasonField(),
                _buildDestinationField(),
                _buildMentorEmailField(),
                _buildMentorContactNumField(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: DateTimeField(
                    onSaved: (DateTime date) {
                      setState(() {
                        _startDate = date;
                      });
                    },
                    format: DateFormat.yMMMEd(),
                    style: TextStyle(color: Colors.cyan, fontFamily: 'Poppins'),
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: "Start Date"),
                    validator: (DateTime value) {
                      if (value == null) {
                        return "Start Date shouldn't be left empty";
                      } else {
                        return null;
                      }
                    },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2022),
                      );
                    },
                  ),
                ),
                BasicTimeField(
                    'Start Time', 'Start time should not be left empty',
                    (DateTime time) {
                  setState(() {
                    _starttime = time;
                  });
                }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: DateTimeField(
                    onSaved: (DateTime date) {
                      setState(() {
                        _endDate = date;
                      });
                    },
                    format: DateFormat.yMMMEd(),
                    style: TextStyle(color: Colors.cyan),
                    decoration:
                        kTextFieldDecoration.copyWith(labelText: "End Date"),
                    validator: (DateTime value) {
                      if (value == null) {
                        return "End Date shouldn't be left empty";
                      } else {
                        return null;
                      }
                    },
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                        context: context,
                        firstDate: DateTime(2019),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2022),
                      );
                    },
                  ),
                ),
                BasicTimeField('End Time', 'End Time should not be left empty',
                    (DateTime time) {
                  setState(() {
                    _endTime = time;
                  });
                }),
                SizedBox(
                  height: 40,
                ),
                Container(
                  //elevation: 5.0,
                  //color: colour,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blue[600],
                  ),
                  //borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }

                      _formKey.currentState.save();

                      print(_Reason);
                      print(_Destination);
                      print(_MentorEmail);
                      print(_MentorContactNum);
                      print(_startDate);
                      print(_endDate);
                      print(_starttime);
                      print(_endTime);
                    },
                    minWidth: 200.0,
                    height: 50.0,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final String labeltext;
  final String timevalidation;
  final Function onSaved;
  final format = DateFormat.Hm();

  BasicTimeField(this.labeltext, this.timevalidation, this.onSaved);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: DateTimeField(
        onSaved: onSaved,
        decoration: kTextFieldDecoration.copyWith(
          labelText: labeltext,
        ),
        validator: (DateTime value) {
          if (value == null) {
            return timevalidation;
          } else {
            return null;
          }
        },
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    );
  }
}
