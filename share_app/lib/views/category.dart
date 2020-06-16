import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/card_category.dart';
import 'package:Share/widgets/effects/shadow.dart';
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

  @override
  Widget build(BuildContext context) {
    print(_buildCategory());

    return Scaffold(
      body: Center(
        child: ListView.separated(
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
                      stuff: key,
                      list: _buildCategory().values.elementAt(index),
                    );
                  },
                );
              },
              child: CategoryCard(
                mib: key,
              ),
            );
          },
        ),
      ),
    );
  }
}

class BuildAlertCategories extends StatelessWidget {
  const BuildAlertCategories({
    Key key,
    @required this.stuff,
    this.list,
  }) : super(key: key);

  final Mibs stuff;
  final List<Mib> list;

  List<Widget> sub(List<Mib> temp, Mibs lvl) {
    List<Widget> sub = new List<Widget>();

    temp.where((element) => element.category == lvl).forEach((element) {
      sub.add(
        Text(
          element.identify +
              " - " +
              element.ip.address +
              " - " +
              element.category.toString() +
              "\n",
        ),
      );
    });

    return sub;
  }

  String titleCatMib(Mibs mib) {
    switch (mib) {
      case Mibs.MATHEMATICS:
        return "Mathematics";
      case Mibs.TEMPERATURE:
        return "Temperature";
      case Mibs.UNKNOWN:
        return "Unkown";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      title: Row(
        children: <Widget>[
          Text(
            titleCatMib(stuff),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: Neumorphism.boxShadow(context),
              color: Colors.white,
            ),
            child: Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: sub(
            list,
            stuff,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
