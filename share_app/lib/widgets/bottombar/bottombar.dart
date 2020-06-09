import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBarApp extends StatelessWidget {
  const BottomBarApp({
    Key key,
    @required int bottomNavIndex,
    @required Animation<double> animation,
    @required this.onTap,
  })  : _bottomNavIndex = bottomNavIndex,
        _animation = animation,
        super(key: key);

  final int _bottomNavIndex;
  final Animation<double> _animation;
  final Function onTap;

  List<IconData> _buildIcon() {
    return <IconData>[
      Icons.library_books,
      Icons.insert_chart,
      Icons.layers,
      Icons.settings,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: _buildIcon(),
      activeIndex: _bottomNavIndex,
      inactiveColor: Theme.of(context).disabledColor,
      notchAndCornersAnimation: _animation,
      splashSpeedInMilliseconds: 300,
      activeColor: Theme.of(context).primaryColor,
      notchSmoothness: NotchSmoothness.smoothEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 22,
      rightCornerRadius: 22,
      onTap: onTap,
    );
  }
}
