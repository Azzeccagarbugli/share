import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:flutter/material.dart';

class ServiceView extends StatefulWidget {
  final Mib mib;

  const ServiceView({Key key, this.mib}) : super(key: key);

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  String a = "start_value";

  Future<String> _callBuild() async {
    String _temp;
    await NetworkController.callSingleValue(widget.mib, "no_param");
    await Future.delayed(
      Duration(seconds: 2),
      () {
        _temp = NetworkController.singleCalls;
      },
    );

    return _temp;
  }

  Widget homePageWithoutParam() {
    return Scaffold(
      body: FutureBuilder(
        future: _callBuild(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return NoDeviceFound(
                icon: Icon(
                  Icons.watch_later,
                  color: Colors.grey[800],
                ),
                msg: "Waiting for the value to reach the device",
              );
            default:
              if (snapshot.hasError)
                return Text(
                  'Error: ${snapshot.error}',
                );
              else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 290,
                        width: 290,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: Neumorphism.boxShadow(context),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${snapshot.data.toString().substring(0, 5)}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 62,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "° C",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 62,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
          }
        },
      ),
    );
  }

  Widget homePageWithParam() {
    return Scaffold();
  }

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
    return homePageWithoutParam();
    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () async {
    //       await NetworkController.callSingleValue(widget.mib, a);
    //       Future.delayed(
    //         Duration(seconds: 2),
    //         () => _showMyDialog(
    //           NetworkController.singleCalls,
    //         ),
    //       );
    //     },
    //     child: Icon(
    //       Icons.category,
    //     ),
    //   ),
    //   body: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       Text(
    //         widget.mib.ip.address + "\n" + widget.mib.identify + "\n",
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(14.0),
    //         child: TextField(
    //           onChanged: (String b) {
    //             setState(() {
    //               a = b;
    //             });
    //           },
    //           cursorColor: Theme.of(context).primaryColor,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(),
    //             labelText: 'Insert a value',
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
