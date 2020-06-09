import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:Share/widgets/bottombar/bottombar.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  var _bottomNavIndex = 0;

  AnimationController _animationController;
  Animation<double> _animation;
  CurvedAnimation _curve;

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
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Theme.of(context).buttonColor,
          child: Icon(
            Icons.filter_tilt_shift,
            color: Colors.white,
          ),
          onPressed: () {
            var DESTINATION_ADDRESS = InternetAddress("10.0.2.2");

            RawDatagramSocket.bind(InternetAddress.anyIPv4, 7878)
                .then((RawDatagramSocket udpSocket) {
              udpSocket.broadcastEnabled = true;
              udpSocket.listen((e) {
                Datagram dg = udpSocket.receive();
                if (dg != null) {
                  print("received ${String.fromCharCodes(dg.data)}");
                }
              });
              List<int> data = utf8.encode('TEST');
              udpSocket.send(data, DESTINATION_ADDRESS, 7878);
            });
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
