import 'package:Share/views/discovery.dart';
import 'package:Share/widgets/bottombar/central_button.dart';
import 'package:Share/widgets/temp_widget.dart';
import 'package:flutter/material.dart';
import 'package:Share/widgets/bottombar/bottombar.dart';

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
      case -1:
        return DiscoveryView();
      case 0:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 1:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 2:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      case 3:
        return TempWidget(context: context, bottomNavIndex: _bottomNavIndex);
      default:
        return DiscoveryView();
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
