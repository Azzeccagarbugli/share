import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/card_category.dart';
import 'package:flutter/material.dart';

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
  List<Mib> _buildCategory() {
    List<Mib> mibs = new List<Mib>();

    widget.str.values.forEach((listMibs) {
      listMibs.forEach((currentMib) {
        if (!listMibs.contains(currentMib.category)) {
          mibs.add(currentMib.putInCategory());
        }
      });
    });

    return mibs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(
            height: 0,
          ),
          itemCount: _buildCategory().length,
          itemBuilder: (context, index) {
            return CategoryCard(
              mib: _buildCategory()[index],
            );
          },
        ),
      ),
    );
  }
}
