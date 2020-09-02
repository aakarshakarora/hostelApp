import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kCardTextStyle = TextStyle(fontSize: 17);

const kTextFieldDecoration = InputDecoration(
  labelText: '',
  labelStyle:
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 17),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
