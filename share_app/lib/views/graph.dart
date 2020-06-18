import 'dart:async';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:flutter/material.dart';

class GraphView extends StatefulWidget {
  final List<Mib> str;

  const GraphView({
    Key key,
    this.str,
  }) : super(key: key);

  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  List<String> _listValues = new List<String>();

  @override
  void initState() {
    super.initState();
    // Mib _currentMib = widget.str
    //     .where((element) => element.category == Mibs.TEMPERATURE)
    //     .single;
    // Timer.periodic(Duration(seconds: 5), (Timer t) {
    //   setState(() {
    //     print(_currentMib);
    //     _listValues.add(
    //       NetworkController.call(
    //         _currentMib.ip,
    //         _currentMib.identify,
    //         "temp",
    //       ),
    //     );
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    print(_listValues);

    return Scaffold(
      body: Container(),
    );
  }
}
