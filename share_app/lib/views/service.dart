import 'dart:convert';
import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:flutter/material.dart';
import 'package:luavm/luavm.dart';

class ServiceView extends StatefulWidget {
  final Mib mib;

  const ServiceView({Key key, this.mib}) : super(key: key);

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  String a;

  Future<List<dynamic>> setUpLua(String func) async {
    await Luavm.open("call");

    await Luavm.eval("call", func);
    final res = await Luavm.eval("call", "return call_tcp()");

    print("LA COMPUTAZIONE È: " + res.toString());

    await Luavm.close("call");

    return res;
  }

  Future call() async {
    await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      8888,
    ).then(
      (RawDatagramSocket udpSocket) {
        udpSocket.listen((e) async {
          switch (e) {
            case RawSocketEvent.read:
              print("CALL");

              String l = String.fromCharCodes(udpSocket.receive().data);

              l = l.replaceAll(
                  "return function(data, ip)", "function call_tcp()");
              l = l.replaceAll("data", '"3"');
              l = l.replaceAll("ip", '"${widget.mib.ip.address}"');

              print(l);

              await setUpLua(l);
              break;
            case RawSocketEvent.readClosed:
            case RawSocketEvent.closed:
              break;
          }
        });

        udpSocket.send(
          utf8.encode('mib, param = "${widget.mib.identify}", 2'),
          widget.mib.ip,
          8888,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(a);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          call();
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
