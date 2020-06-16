import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'effects/shadow.dart';

class AddLocalService extends StatelessWidget {
  const AddLocalService({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.purple[900],
      ),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.purple[800],
                  Colors.purple[700],
                  Colors.purple[600],
                  Colors.purple[500],
                ],
                durations: [35000, 19440, 10800, 6000],
                heightPercentages: [0.0, 0.6, 0.7, 0.80],
              ),
              waveAmplitude: 0,
              size: Size(
                double.infinity,
                double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            top: 0,
            left: 16,
            right: 66,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                16,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Use the sensors of this device and share them to the local network",
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            top: 12,
            child: FloatingActionButton(
              elevation: 4,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add,
                color: Theme.of(context).buttonColor,
              ),
              onPressed: () {
                print("Aggiunto service (da implemetare)");
              },
            ),
          )
        ],
      ),
    );
  }
}
