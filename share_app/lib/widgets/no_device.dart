import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NoDeviceFound extends StatelessWidget {
  final String msg;
  final Icon icon;

  const NoDeviceFound({Key key, this.msg, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 36,
            ),
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: Neumorphism.boxShadow(context),
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                icon,
                Text(
                  msg,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Center(
              child: SpinKitFadingCube(
                color: Theme.of(context).disabledColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
