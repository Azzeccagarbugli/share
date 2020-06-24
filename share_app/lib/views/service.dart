import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  final Mib mib;

  const ServiceView({Key key, this.mib}) : super(key: key);

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  String a = "3";

  // Future<List<dynamic>> setUpLua(String func) async {
  //   await Luavm.open("call");

  //   await Luavm.eval("call", func);
  //   final res = await Luavm.eval("call", "return call_tcp()");

  //   print("LA COMPUTAZIONE È: " + res.toString());

  //   await Luavm.close("call");

  //   return res;
  // }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showMyDialog(
    String ciao,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Computation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('The value is:'),
                Text(ciao),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(a);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await NetworkController.callSingleValue(widget.mib, a);
          Future.delayed(
            Duration(seconds: 2),
            () => _showMyDialog(
              NetworkController.singleCalls,
            ),
          );
        },
        child: Icon(
          Icons.category,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.mib.ip.address + "\n" + widget.mib.identify + "\n",
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: TextField(
              onChanged: (String b) {
                setState(() {
                  a = b;
                });
              },
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Insert a value',
              ),
            ),
          )
        ],
      ),
    );
  }
}
