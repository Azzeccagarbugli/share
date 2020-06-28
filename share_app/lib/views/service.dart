import 'package:Share/logic/network_udp.dart';
import 'package:Share/models/mib.dart';
import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:Share/widgets/no_device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ServiceView extends StatefulWidget {
  final Mib mib;

  const ServiceView({Key key, this.mib}) : super(key: key);

  @override
  _ServiceViewState createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  String param = "0";

  Future<String> _callBuild(String value) async {
    String _temp;
    await NetworkController.callSingleValue(widget.mib, value);
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
        future: _callBuild("no_temp"),
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
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                  ),
                );
              else
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
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
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Chip(
                            elevation: 6,
                            backgroundColor: Colors.pink[600],
                            label: Text(
                              "Share",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.share,
                                color: Colors.pink[600],
                                size: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Chip(
                            elevation: 6,
                            backgroundColor: Theme.of(context).buttonColor,
                            label: Text(
                              "Help",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            avatar: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.help,
                                color: Theme.of(context).buttonColor,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                color: Colors.purple[50],
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: Neumorphism.boxShadow(context),
                      ),
                      child: TextField(
                        onSubmitted: (String _param) {
                          setState(() {
                            param = _param;
                          });
                        },
                        keyboardType: TextInputType.number,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(16.0),
                            ),
                          ),
                          labelText: 'Insert a value',
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.power_input,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _callBuild(param),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                      child: Center(
                        child: SpinKitFadingCube(
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                        ),
                      );
                    else
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          Text(
                            "The current value is",
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            snapshot.data == "nil"
                                ? "Not yet calculated"
                                : snapshot.data,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Chip(
                                  elevation: 6,
                                  backgroundColor: Colors.pink[600],
                                  label: Text(
                                    "Share",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.pink[600],
                                      size: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Chip(
                                  elevation: 6,
                                  backgroundColor:
                                      Theme.of(context).buttonColor,
                                  label: Text(
                                    "Help",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  avatar: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.help,
                                      color: Theme.of(context).buttonColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.mib.category) {
      case Mibs.TEMPERATURE:
        return homePageWithoutParam();
      default:
        return homePageWithParam();
    }
  }
}
