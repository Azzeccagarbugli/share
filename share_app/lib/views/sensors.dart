import 'dart:async';

import 'package:Share/widgets/add_service_local.dart';
import 'package:Share/widgets/card_sensor.dart';
import 'package:Share/widgets/circle_graph.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class SensorsView extends StatefulWidget {
  const SensorsView({
    Key key,
  }) : super(key: key);

  @override
  _SensorsViewState createState() => _SensorsViewState();
}

class _SensorsViewState extends State<SensorsView> {
  List<double> _accelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();

    return Scaffold(
      body: ListView(
        children: <Widget>[
          MiniCard(
            boolWaves: false,
            text: "Your sensors here for you and for\nyour whole network!",
            icon: Icon(
              Icons.developer_mode,
              color: Colors.white,
            ),
            onTap: () {},
          ),
          CardValueSensor(
            sensor: accelerometer == null ? ["0", "0", "0"] : accelerometer,
            subtitile:
                "A tool that measures proper acceleration of a body in its own instantaneous rest frame",
            title: "Accelerometer",
          ),
          CardValueSensor(
            sensor: gyroscope == null ? ["0", "0", "0"] : gyroscope,
            subtitile: "Used for measuring orientation and angular velocity",
            title: "Gyroscope",
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions
        .add(accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _accelerometerValues = <double>[event.x, event.y, event.z];
      });
    }));
    _streamSubscriptions.add(gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroscopeValues = <double>[event.x, event.y, event.z];
      });
    }));
  }
}
