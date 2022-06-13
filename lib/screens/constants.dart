import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0)),
  ),
);

const kMessageContainerDecoration = BoxDecoration(

    // border: Border(
    //   top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    // ),
    );
const kTextFieldInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        bottomLeft: Radius.circular(32.0),
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightGreen, width: 1.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        bottomLeft: Radius.circular(32.0),
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightGreen, width: 2.0),
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32.0),
        bottomLeft: Radius.circular(32.0),
        topRight: Radius.circular(10.0),
        bottomRight: Radius.circular(10.0)),
  ),
);
