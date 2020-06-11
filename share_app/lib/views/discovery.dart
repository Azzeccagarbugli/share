import 'dart:io';

import 'package:Share/widgets/effects/shadow.dart';
import 'package:Share/widgets/temp_widget.dart';
import 'package:flutter/material.dart';

class DiscoveryView extends StatefulWidget {
  final Map<InternetAddress, List<String>> str;

  const DiscoveryView({
    Key key,
    this.str,
  }) : super(key: key);

  @override
  _DiscoveryViewState createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  @override
  Widget build(BuildContext context) {
    print(widget.str.toString());
    return Scaffold(
      body: Center(
        child: widget.str.isNotEmpty
            ? ListView.builder(
                itemCount: widget.str.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardIpMib(
                    ip: widget.str.keys.toList()[index],
                    mibs: widget.str.values.toList()[index],
                  );
                },
              )
            : TempWidget(
                context: context,
                bottomNavIndex: -98,
              ),
      ),
    );
  }
}

class CardIpMib extends StatelessWidget {
  final InternetAddress ip;
  final List<String> mibs;

  const CardIpMib({Key key, this.ip, this.mibs}) : super(key: key);

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
      child: ListTile(
        title: Text(
          ip.address,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          mibs.toString(),
        ),
      ),
    );
  }
}
