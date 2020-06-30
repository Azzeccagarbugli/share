import 'package:flutter/material.dart';

class CardSensorShare extends StatelessWidget {
  const CardSensorShare({
    Key key,
    this.title,
    this.subtitle,
    this.onTap,
    this.color,
    this.icon,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Function onTap;
  final Color color;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.pink[800],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[100],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.pink[100],
                  child: Icon(
                    Icons.help,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                  heroTag: null,
                  onPressed: onTap,
                  backgroundColor: color,
                  child: icon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
