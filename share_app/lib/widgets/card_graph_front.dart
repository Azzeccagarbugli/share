import 'package:Share/models/mib.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import 'effects/shadow.dart';

class CardGraphFront extends StatelessWidget {
  const CardGraphFront({
    Key key,
    @required ScrollController scrollController,
    @required LineChartData lineChartData,
    this.device,
  })  : _scrollController = scrollController,
        _lineChartData = lineChartData,
        super(key: key);

  final ScrollController _scrollController;
  final LineChartData _lineChartData;
  final Mib device;

  List<Widget> _buildLateralList() {
    List<Widget> _list = new List<Widget>();

    for (var i = 0; i < 12; i++) {
      if (i % 2 == 0) {
        _list.add(
          Text(
            (i * 2.5).toStringAsFixed(0) + "° C",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    }

    return _list.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                controller: _scrollController,
                child: Container(
                  width: MediaQuery.of(context).size.width * 2,
                  child: LineChart(
                    _lineChartData,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 310,
              bottom: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: Neumorphism.boxShadow(context),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildLateralList(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              top: 152,
              right: 0,
              child: ClipPath(
                clipper: WaveClipperTwo(
                  reverse: true,
                ),
                child: Container(
                  color: Colors.purple[900],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Temperature",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Chart from ${device.identify}",
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 280,
              right: 0,
              top: 180,
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 6,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.share,
                  color: Colors.purple[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
