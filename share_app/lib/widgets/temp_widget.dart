import 'package:flutter/material.dart';

import 'effects/shadow.dart';

class TempWidget extends StatelessWidget {
  const TempWidget({
    Key key,
    @required this.context,
    @required int bottomNavIndex,
  })  : _bottomNavIndex = bottomNavIndex,
        super(key: key);

  final BuildContext context;
  final int _bottomNavIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          boxShadow: Neumorphism.boxShadow(context),
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(22),
          ),
        ),
        child: Center(
          child: Text(
            this._bottomNavIndex.toString(),
            style: TextStyle(
              fontSize: 62,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
