import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';

class CircleDataGraph extends StatelessWidget {
  const CircleDataGraph({
    Key key,
    this.value,
    this.label,
    this.icon,
    this.color,
  }) : super(key: key);

  final String value;
  final String label;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: Neumorphism.boxShadow(context),
            color: Colors.white,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: Text(
                "$value°",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          top: 68,
          left: 0,
          child: Chip(
            elevation: 8,
            backgroundColor: color,
            padding: EdgeInsets.all(8),
            avatar: CircleAvatar(
              child: icon,
              backgroundColor: Colors.white,
            ),
            label: Text(
              label.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
