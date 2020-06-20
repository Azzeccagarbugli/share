import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:fl_chart/fl_chart.dart';
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
  Timer _timer;

  Mib _currentMib;

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  // Future<List<String>> _netValue(Mib mib, List<String> list) async {
  //   String value = await NetworkController.call(mib.ip, mib.identify, "temp");
  //   list.add(value);
  //   return list;
  // }

  // Future _setUp(Mib mib) async {
  //   _socket = await RawDatagramSocket.bind(
  //     InternetAddress.anyIPv4,
  //     9999,
  //   );

  // }

  @override
  void initState() {
    super.initState();
    _currentMib = widget.str
        .where((element) => element.category == Mibs.TEMPERATURE)
        .single;

    // _setUp(_currentMib);
    _timer = new Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        // print(_currentMib);
        // _listValues.add(await _netValue(_currentMib));
        NetworkController.call(_currentMib, "temp");
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(NetworkController.values.toString());

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              NetworkController.values.toString(),
            ),
          ],
        ),
        // child: FutureBuilder(
        //   future: NetworkController.call(
        //     _currentMib.ip,
        //     _currentMib.identify,
        //     "temp",
        //   ),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.data == null) {
        //       return CircularProgressIndicator();
        //     }

        //     _listValues.add(snapshot.data.toString());

        //     return Text(_listValues.toString());
        //   },
        // ),
      ),
    );
  }
}
