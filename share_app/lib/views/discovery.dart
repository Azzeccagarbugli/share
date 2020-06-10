import 'dart:io';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:Share/widgets/temp_widget.dart';
import 'package:flutter/material.dart';

class DiscoveryView extends StatefulWidget {
  @override
  _DiscoveryViewState createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  NetworkController _networkController = new NetworkController(
    ip: [
      InternetAddress("10.0.2.2"),
    ],
  );

  Map<InternetAddress, List<String>> _devices =
      new Map<InternetAddress, List<String>>();

  @override
  void initState() {
    super.initState();
    _networkController.setUpUDP();
    _devices = _networkController.getStructure();
  }

  @override
  Widget build(BuildContext context) {
    print(_devices.length);

    return Scaffold(
      body: Center(
        child: _devices.isNotEmpty
            ? ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardIpMib(
                    ip: _devices.keys.toList()[index],
                    mibs: _devices.values.toList()[index],
                  );
                },
              )
            : TempWidget(
                context: context,
                bottomNavIndex: -1,
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
