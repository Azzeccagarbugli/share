import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/add_service_local.dart';
import 'package:Share/widgets/alert_homepage.dart';
import 'package:Share/widgets/card_category.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CategoriesView extends StatefulWidget {
  final Map<InternetAddress, List<Mib>> str;

  const CategoriesView({
    Key key,
    this.str,
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

    return mibs;
  }

  Widget _buildView(int lenght) {
    switch (lenght) {
      case 0:
        return NoDeviceFound();
      default:
        return ListView(
          children: <Widget>[
            AddLocalService(),
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
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => Divider(
                height: 0,
              ),
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
