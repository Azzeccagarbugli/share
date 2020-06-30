import 'dart:ui';

import 'package:Share/models/service.dart';
import 'package:Share/models/share.dart';
import 'package:Share/widgets/card_sensor_share.dart';
import 'package:flutter/material.dart';

class SelectionShareView extends StatefulWidget {
  final Share share;

  const SelectionShareView({Key key, this.share}) : super(key: key);

  @override
  _SelectionShareViewState createState() => _SelectionShareViewState();
}

class _SelectionShareViewState extends State<SelectionShareView> {
  final Service _acc = new Service("9.9.3", "43", () => true);
  final Service _gyr = new Service("9.9.2", "98", () => true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200].withOpacity(0.7),
      body: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.pink,
                ),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        "Connected devices",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.fiber_manual_record,
                        size: 14,
                        color: Colors.pinkAccent,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "The devices that you shared are ${widget.share.services.length}",
                    style: TextStyle(
                      color: Colors.grey[100],
                    ),
                  ),
                ),
              ),
              Container(
                height: 8,
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(96),
                  color: Colors.pink[100],
                ),
              ),
              CardSensorShare(
                color: !widget.share.services.contains(_acc)
                    ? Colors.pink[400]
                    : Colors.orange[400],
                icon: Icon(
                  !widget.share.services.contains(_acc)
                      ? Icons.add
                      : Icons.remove,
                ),
                onTap: () {
                  setState(() {
                    !widget.share.services.contains(_acc)
                        ? widget.share.attach(_acc)
                        : widget.share.detach(_acc);
                  });
                },
                subtitle:
                    "Accelerometers have many uses in industry and science. Highly sensitive accelerometers are used in inertial navigation systems for aircraft and missiles",
                title: "Accelerometer",
              ),
              CardSensorShare(
                color: !widget.share.services.contains(_gyr)
                    ? Colors.pink[400]
                    : Colors.orange[400],
                icon: Icon(
                  !widget.share.services.contains(_gyr)
                      ? Icons.add
                      : Icons.remove,
                ),
                onTap: () {
                  setState(() {
                    !widget.share.services.contains(_gyr)
                        ? widget.share.attach(_gyr)
                        : widget.share.detach(_gyr);
                  });
                },
                subtitle:
                    "Applications of gyroscopes include inertial navigation systems, such as in the Hubble Telescope, or inside the steel hull of a submerged submarine",
                title: "Gyroscope",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
