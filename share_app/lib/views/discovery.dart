import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/widgets/card_homepage_ip_mib.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:flutter/material.dart';

class DiscoveryView extends StatefulWidget {
  final Map<InternetAddress, List<Mib>> str;

  const DiscoveryView({
    Key key,
    this.str,
  }) : super(key: key);

  @override
  _DiscoveryViewState createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  Widget _buildView(int lenght) {
    switch (lenght) {
      case 0:
        return NoDeviceFound(
          icon: Icon(
            Icons.do_not_disturb_on,
            color: Colors.grey[800],
          ),
          msg: "No device still found, be sure to connect them",
        );
      default:
        return ListView.separated(
          separatorBuilder: (_, __) => Divider(
            height: 0,
          ),
          itemCount: widget.str.length,
          itemBuilder: (BuildContext context, int index) {
            return CardIpMib(
              ip: widget.str.keys.toList()[index],
              mibs: widget.str.values.toList()[index],
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildView(widget.str.length),
      ),
    );
  }
}
