import 'dart:async';
import 'dart:io';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/models/service.dart';
import 'package:Share/models/share.dart';
import 'package:Share/views/category.dart';
import 'package:Share/views/discovery.dart';
import 'package:Share/views/settings.dart';
import 'package:Share/widgets/bottombar/central_button.dart';
import 'package:Share/widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:Share/widgets/bottombar/bottombar.dart';

import 'graph.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  int _bottomNavIndex = -1;

  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curve;

  Share _share;

  Service _service = new Service("9.9.9", "calcolo = 10", () => true);

  NetworkController _networkController = new NetworkController(
    listIp: [
      InternetAddress("80.211.186.133"),
      InternetAddress("10.0.2.2"),
    ],
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_curve);
    Future.delayed(
      Duration(milliseconds: 400),
      () => _animationController.forward(),
    );

    _share = new Share(
      <Service>[
        _service,
      ],
    );

    Timer.periodic(Duration(seconds: 2), (Timer t) {
      setState(() {
        _networkController.setUpUDP();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Mib> _buildListMib(Map<InternetAddress, List<Mib>> map) {
    List<Mib> _temp = new List<Mib>();

    map.values.forEach((list) {
      list.forEach((mib) {
        _temp.add(mib.putInCategory());
      });
    });

    return _temp;
  }

  Widget _buildScreen(int x) {
    switch (x) {
      case -1:
        return CategoriesView(
          str: _networkController.str,
        );
      case 0:
        return DiscoveryView(
          str: _networkController.str,
        );
      case 1:
        return GraphView(
          str: _buildListMib(_networkController.str),
        );
      case 2:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 3:
        return SettingsView();
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // NetworkController.openPortUdp();

    return Scaffold(
      extendBody: true,
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: MainButtonNavBar(
          onTap: () {
            setState(() {
              _bottomNavIndex = -1;
              _networkController.setUpUDP();
            });
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarApp(
        animation: _animation,
        bottomNavIndex: _bottomNavIndex,
        onTap: (index) => setState(
          () => _bottomNavIndex = index,
        ),
      ),
      body: _buildScreen(
        _bottomNavIndex,
      ),
    );
  }
}
