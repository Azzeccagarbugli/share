import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class CardIpMib extends StatelessWidget {
  final InternetAddress ip;
  final List<Mib> mibs;

  const CardIpMib({Key key, this.ip, this.mibs}) : super(key: key);

  List<Widget> _buildCard(List<Mib> list, BuildContext context) {
    List<Widget> temp = new List<Widget>();
    list.forEach((element) {
      temp.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: Neumorphism.boxShadow(context),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.fiber_smart_record,
                    color: Colors.grey[200],
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 52,
                    child: Center(
                      child: Text(
                        element.identify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.fiber_manual_record,
                    size: 12,
                    color: Colors.green[100],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 96,
            bottom: 0,
            right: 0,
            left: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ClipPath(
                clipper: WaveClipperTwo(
                  reverse: true,
                  flip: true,
                ),
                child: Container(
                  color: Colors.purple[50],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Chip(
                      backgroundColor: Theme.of(context).buttonColor,
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.settings_input_antenna,
                          color: Theme.of(context).buttonColor,
                          size: 16,
                        ),
                      ),
                      label: Text(
                        ip.address,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Chip(
                      backgroundColor: Colors.purple[300],
                      avatar: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.search,
                          color: Colors.purple[300],
                          size: 16,
                        ),
                      ),
                      label: Text(
                        ip.type.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.fiber_manual_record,
                      size: 12,
                      color: Colors.green,
                    )
                  ],
                ),
                Column(
                  children: _buildCard(mibs, context),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
