import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/views/service.dart';
import 'package:flutter/material.dart';

import 'effects/shadow.dart';

class BuildAlertCategories extends StatelessWidget {
  const BuildAlertCategories({
    Key key,
    @required this.mibAlert,
    this.list,
  }) : super(key: key);

  final Mibs mibAlert;
  final List<Mib> list;

  List<Widget> sub(List<Mib> temp, Mibs lvl, BuildContext context) {
    List<Widget> sub = new List<Widget>();

    temp.where((element) => element.category == lvl).forEach((element) {
      sub.add(
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceView(
                  mib: element,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              boxShadow: Neumorphism.boxShadow(context),
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
            child: ListTile(
              title: Text(
                element.identify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                element.ip.address,
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      );
    });
    sub.add(
      SizedBox(
        height: 16,
      ),
    );
    sub.add(
      Center(
        child: Container(
          width: double.infinity,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(96.0),
              ),
            ),
            color: Theme.of(context).accentColor,
            child: Text(
              "About this category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );

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
            titleCatMib(mibAlert),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: sub(
            list,
            mibAlert,
            context,
          ),
        ),
      ),
    );
  }
}
