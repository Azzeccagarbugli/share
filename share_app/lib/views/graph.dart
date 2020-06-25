import 'dart:async';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/add_service_local.dart';
import 'package:Share/widgets/card_graph_back.dart';
import 'package:Share/widgets/card_graph_front.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flip_card/flip_card.dart';
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

  Map<Mib, List<String>> _map = new Map();

  List<Color> gradientColors = [
    const Color(0xff9c27b0),
  ];

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 50.0,
  );

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey[100],
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey[100],
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
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: _index,
      minY: 0,
      maxY: 30,
      lineBarsData: [
        LineChartBarData(
          spots: _buildDouble(),
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
    _timer = new Timer.periodic(Duration(seconds: 2), (Timer t) {
      if (widget.str.isNotEmpty) {
        _currentMib = widget.str
            .where((element) => element.category == Mibs.TEMPERATURE)
            .first;
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
        setState(() {
          NetworkController.callGraph(_currentMib, "temp");
          _map = NetworkController.graph;
          _index++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _map.clear();
    if (widget.str.isNotEmpty) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  List<FlSpot> _buildDouble() {
    List<FlSpot> _list = new List<FlSpot>();

    double i = 0;
    _map.values.forEach((l) {
      l.forEach((element) {
        _list.add(FlSpot(i, double.parse(element)));
        i++;
      });
    });

    return _list;
  }

  List<double> _buildValuesDouble() {
    List<double> _list = new List<double>();

    _map.values.forEach((l) {
      l.forEach((element) {
        _list.add(double.parse(element));
      });
    });

    return _list;
  }

  _scrollToEnd() async {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent -
            (_scrollController.position.maxScrollExtent / 1.5),
        duration: Duration(
          seconds: 4,
        ),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _map.isNotEmpty
          ? ListView(
              children: <Widget>[
                MiniCard(
                  boolWaves: false,
                  text:
                      "Cloud means easy configuration, watch your devices helping you!",
                  icon: Icon(
                    Icons.cloud_queue,
                    color: Colors.white,
                  ),
                  onTap: () {},
                ),
                FlipCard(
                  direction: FlipDirection.VERTICAL,
                  front: CardGraphFront(
                    scrollController: _scrollController,
                    lineChartData: mainData(),
                    device: _currentMib,
                  ),
                  back: CardGraphBack(
                    list: _buildValuesDouble(),
                    mib: _currentMib,
                  ),
                ),
              ],
            )
          : NoDeviceFound(
              icon: Icon(
                Icons.do_not_disturb_on,
                color: Colors.grey[800],
              ),
              msg: "No device still found, be sure to connect them",
            ),
    );
  }
}
