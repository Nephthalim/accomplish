import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Color.fromRGBO(205, 180, 180, 1.0),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: handler,
          )
        : FlatButton(
            color: Color.fromRGBO(205, 180, 180, 1.0),
            textColor: Theme.of(context).primaryColor,
            child: Text(
              "Choose Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            onPressed: handler,
          );
  }
}
