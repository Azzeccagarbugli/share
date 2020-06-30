import 'package:Share/widgets/circle_graph.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';

class CardValueSensor extends StatelessWidget {
  const CardValueSensor({
    Key key,
    @required this.sensor,
    this.title,
    this.subtitile,
  }) : super(key: key);

  final List<String> sensor;
  final String title;
  final String subtitile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                  fontSize: 22,
                ),
              ),
              Spacer(),
              Icon(
                Icons.track_changes,
                color: Colors.grey[300],
                size: 14,
              )
            ],
          ),
          Text(subtitile),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleDataGraph(
                icon: Icon(
                  Icons.slow_motion_video,
                  color: Colors.purple[400],
                  size: 14,
                ),
                label: "Axis Z",
                value: sensor[0],
                color: Colors.purple[400],
              ),
              CircleDataGraph(
                icon: Icon(
                  Icons.slow_motion_video,
                  color: Colors.purple[400],
                  size: 14,
                ),
                label: "Axis X",
                value: sensor[1],
                color: Colors.purple[400],
              ),
              CircleDataGraph(
                icon: Icon(
                  Icons.slow_motion_video,
                  color: Colors.purple[400],
                  size: 14,
                ),
                label: "Axis Y",
                value: sensor[2],
                color: Colors.purple[400],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
