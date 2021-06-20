import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

onAlertButtonsPressed(
    {context, type, title, desc, label1, label2, onPressed1, onPressed2}) {
  var alertStyle = AlertStyle(
    isCloseButton: false,
  );
  Alert(
    style: alertStyle,
    context: context,
    type: type,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text(
          label1,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: onPressed1,
        color: Color.fromRGBO(129, 28, 51, 1),
      ),
      DialogButton(
        child: Text(
          label2,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: onPressed2,
        color: Color.fromRGBO(129, 28, 51, 1),
      ),
    ],
  ).show();
}
