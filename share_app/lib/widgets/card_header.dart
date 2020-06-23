import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildCardHeader extends StatelessWidget {
  const BuildCardHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: new SvgPicture.asset(
                "assets/images/sett.svg",
                alignment: Alignment.topRight,
              ),
            ),
          ),
          Positioned(
            top: 98,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              child: ClipPath(
                clipper: WaveClipperTwo(
                  reverse: true,
                ),
                child: Container(
                  color: Colors.purple[900],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 14,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Settings",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Adjust your style",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
