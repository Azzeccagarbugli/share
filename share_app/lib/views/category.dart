import 'dart:collection';
import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/models/service.dart';
import 'package:Share/models/share.dart';
import 'package:Share/views/selection_share.dart';
import 'package:Share/widgets/add_service_local.dart';
import 'package:Share/widgets/alert_homepage.dart';
import 'package:Share/widgets/card_category.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:flutter/material.dart';

class CategoriesView extends StatefulWidget {
  final Map<InternetAddress, List<Mib>> str;
  final Share share;

  const CategoriesView({
    Key key,
    this.str,
    this.share,
  }) : super(key: key);

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  Map<Mibs, List<Mib>> _buildCategory() {
    Map<Mibs, List<Mib>> mibs = new Map<Mibs, List<Mib>>();
    List<Mib> tempMibs = new List<Mib>();

    widget.str.values.forEach((tem) {
      tem.forEach((item) {
        tempMibs.add(item.putInCategory());
      });
    });

    widget.str.values.forEach((listMibs) {
      listMibs.forEach((currentMib) {
        mibs.putIfAbsent(
            currentMib.checkCategory(),
            () => tempMibs
                .where(
                    (element) => element.category == currentMib.checkCategory())
                .toList());
      });
    });

    return LinkedHashMap.fromEntries(
      mibs.entries.toList()
        ..sort(
          (a, _) => a.key.index,
        ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) =>
          SelectionShareView(
        share: widget.share,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget _buildView(int lenght) {
    switch (lenght) {
      case 0:
        return NoDeviceFound(
          icon: Icon(
            Icons.do_not_disturb_on,
            color: Colors.grey[800],
          ),
          msg: "No device still found, be sure to connect them",
        );
      default:
        return ListView(
          children: <Widget>[
            MiniCard(
              text:
                  "Use the sensors of this device and share them to the local network",
              icon: Icon(
                Icons.add,
                color: Theme.of(context).buttonColor,
              ),
              boolWaves: true,
              onTap: () {
                Navigator.push(context, _createRoute());
              },
            ),
            Container(
              height: 8,
              margin: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(96),
                color: Colors.grey[200],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _buildCategory().length,
              itemBuilder: (context, index) {
                Mibs key = _buildCategory().keys.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    return showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return BuildAlertCategories(
                          mibAlert: key,
                          list: _buildCategory().values.elementAt(index),
                        );
                      },
                    );
                  },
                  child: CategoryCard(
                    mib: key,
                    devices: _buildCategory()
                        .values
                        .elementAt(index)
                        .where((element) => element.category == key)
                        .length,
                  ),
                );
              },
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildView(
          _buildCategory().length,
        ),
      ),
    );
  }
}
