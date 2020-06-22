import 'dart:async';

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

  double _index = 5;

  Map<Mib, List<String>> _map;

  List<Color> gradientColors = [
    const Color(0xffec407a),
    const Color(0xffe9163a),
  ];

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      // extraLinesData: ExtraLinesData(
      //   horizontalLines: [
      //     HorizontalLine(
      //       y: 15,
      //       color: Colors.grey,
      //       dashArray: [2, 6],
      //       label: HorizontalLineLabel(
      //         labelResolver: (_) => "15 °",
      //         show: true,
      //         alignment: Alignment.center,
      //         style: TextStyle(
      //           color: Colors.grey[800],
      //           fontWeight: FontWeight.bold,
      //           fontSize: 22,
      //         ),
      //       ),
      //       strokeWidth: 0.8,
      //     ),
      //     HorizontalLine(
      //       y: 20,
      //       color: Colors.grey,
      //       dashArray: [2, 6],
      //       label: HorizontalLineLabel(
      //         labelResolver: (_) => "20 °",
      //         show: true,
      //         alignment: Alignment.center,
      //         style: TextStyle(
      //           color: Colors.grey[800],
      //           fontWeight: FontWeight.bold,
      //           fontSize: 22,
      //         ),
      //       ),
      //       strokeWidth: 0.8,
      //     ),
      //   ],
      // ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      minX: 0,
      maxX: _index,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: _buildDouble(_map),
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          curveSmoothness: 0.4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _currentMib = widget.str
        .where((element) => element.category == Mibs.TEMPERATURE)
        .single;
    _timer = new Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        NetworkController.call(_currentMib, "temp");
        _map = NetworkController.values;
        _index++;
        _scrollToEnd();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _map.clear();
    _scrollController.dispose();
    super.dispose();
  }

  List<FlSpot> _buildDouble(Map<Mib, List<String>> temp) {
    List<FlSpot> _list = new List<FlSpot>();

    double i = 0;
    temp.values.forEach((l) {
      l.forEach((element) {
        _list.add(FlSpot(i, double.parse(element)));
        i++;
      });
    });

    return _list;
  }

  ScrollController _scrollController = new ScrollController();

  _scrollToEnd() async {
    Future.delayed(
        const Duration(
          seconds: 4,
        ), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent -
            (_scrollController.position.maxScrollExtent / 1.5),
        duration: Duration(
          seconds: 4,
        ),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(NetworkController.values.toString());

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Text(
                NetworkController.values.toString(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Container(
                  width: 1000,
                  child: LineChart(
                    mainData(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
