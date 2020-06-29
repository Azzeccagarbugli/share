import 'dart:math';

import 'package:Share/models/mib.dart';
import 'package:Share/widgets/circle_graph.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';

class CardGraphBack extends StatelessWidget {
  const CardGraphBack({
    Key key,
    this.list,
    this.mib,
  }) : super(key: key);

  final List<double> list;
  final Mib mib;

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
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleDataGraph(
                    icon: Icon(
                      Icons.trending_up,
                      color: Colors.red[400],
                      size: 14,
                    ),
                    label: "max",
                    value: list.reduce(max).toStringAsFixed(0) + "°",
                    color: Colors.red[400],
                  ),
                  CircleDataGraph(
                    icon: Icon(
                      Icons.trending_flat,
                      color: Colors.grey[400],
                      size: 14,
                    ),
                    label: "avg",
                    value: ((list.reduce(max) + list.reduce(min)) / 2)
                            .toStringAsFixed(0) +
                        "°",
                    color: Colors.grey[400],
                  ),
                  CircleDataGraph(
                    icon: Icon(
                      Icons.trending_down,
                      color: Colors.green[400],
                      size: 14,
                    ),
                    label: "min",
                    value: list.reduce(min).toStringAsFixed(0) + "°",
                    color: Colors.green[400],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Data coming from ${mib.ip.address}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.fiber_manual_record,
                        size: 12,
                        color: Colors.green[200],
                      )
                    ],
                  ),
                ),
                subtitle: Text(
                  "The current device is the ${mib.identify} and is running correctly.\nIt belongs to the category ${mib.category}",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                isThreeLine: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
