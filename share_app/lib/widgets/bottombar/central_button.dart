import 'package:flutter/material.dart';
import 'package:spring_button/spring_button.dart';

class MainButtonNavBar extends StatelessWidget {
  final Function onTap;

  const MainButtonNavBar({
    Key key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      Container(
        padding: EdgeInsets.all(
          16.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.filter_tilt_shift,
          color: Colors.white,
          size: 28,
        ),
      ),
      onTap: onTap,
    );
  }
}
