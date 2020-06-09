import 'package:flutter/material.dart';

class Neumorphism {
  static boxShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Colors.grey[500],
        offset: Offset(4.0, 4.0),
        blurRadius: 15.0,
        spreadRadius: 1.0,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(-4.0, -4.0),
        blurRadius: 15.0,
        spreadRadius: 1.0,
      ),
    ];
  }
}
