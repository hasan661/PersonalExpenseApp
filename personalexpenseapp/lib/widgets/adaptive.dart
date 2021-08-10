import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Adaptive extends StatelessWidget {
  final String text;
  final VoidCallback handler;

  Adaptive(this.text,this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              handler();
            },
          )
        : TextButton(
            onPressed: () {
              handler();
            },
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
