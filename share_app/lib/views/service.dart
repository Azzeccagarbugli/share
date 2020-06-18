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
  String a;

  // Future<List<dynamic>> setUpLua(String func) async {
  //   await Luavm.open("call");

  //   await Luavm.eval("call", func);
  //   final res = await Luavm.eval("call", "return call_tcp()");

  //   print("LA COMPUTAZIONE È: " + res.toString());

  //   await Luavm.close("call");

  //   return res;
  // }

  @override
  Widget build(BuildContext context) {
    print(a);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NetworkController.call(widget.mib.ip, widget.mib.identify, a);
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
            widget.mib.ip.address + "\n" + widget.mib.identify,
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
