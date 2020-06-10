import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Share/logic/network_udp.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:Share/widgets/bottombar/bottombar.dart';
import 'package:spring_button/spring_button.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = -1;

  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curve;

  NetworkController _networkController = new NetworkController(
    ip: InternetAddress("10.0.2.2"),
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
    _networkController.setUpUDP();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  Widget _buildScreen(int x) {
    switch (x) {
      case 0:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 1:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 2:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 3:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      default:
        return BuildCardInfoDevicesMib(
          context: context,
          map: _networkController.getStructure(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: MainButtonNavBar(
          onTap: () {
            setState(() {
              _bottomNavIndex = -1;
            });

            _networkController.setUpUDP();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarApp(
        animation: _animation,
        bottomNavIndex: _bottomNavIndex,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      body: _buildScreen(_bottomNavIndex),
    );
  }
}

class BuildCardInfoDevicesMib extends StatelessWidget {
  const BuildCardInfoDevicesMib({
    Key key,
    @required this.context,
    @required this.map,
  }) : super(key: key);

  final BuildContext context;
  final Map<InternetAddress, List<String>> map;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: map.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: Neumorphism.boxShadow(context),
                color: Colors.white,
              ),
              child: ListTile(
                title: Text(
                  map.keys.toList()[index].address,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  map.values.toList()[index].toList().toString(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MainButtonNavBar extends StatelessWidget {
  final Function onTap;

  const MainButtonNavBar({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpringButton(
      SpringButtonType.OnlyScale,
      Container(
        padding: EdgeInsets.all(
          16.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.filter_tilt_shift,
          color: Colors.white,
          size: 28,
        ),
      ),
      onTap: onTap,
    );
  }
}

class TempWidget extends StatelessWidget {
  const TempWidget({
    Key key,
    @required this.context,
    @required int bottomNavIndex,
  })  : _bottomNavIndex = bottomNavIndex,
        super(key: key);

  final BuildContext context;
  final int _bottomNavIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            boxShadow: Neumorphism.boxShadow(context),
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(22),
            ),
          ),
          child: Center(
            child: Text(
              this._bottomNavIndex.toString(),
              style: TextStyle(
                fontSize: 62,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
