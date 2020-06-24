import 'dart:convert';
import 'dart:io';

import 'package:Share/models/mib.dart';
import 'package:Share/models/share.dart';

class NetworkController {
  final List<InternetAddress> listIp;
  final int port;

  NetworkController({
    this.listIp,
    this.port = 7878,
  });

  RawDatagramSocket _udpSocket;

  Map<InternetAddress, List<Mib>> str = new Map<InternetAddress, List<Mib>>();

  static Map<Mib, List<String>> graph = new Map<Mib, List<String>>();

  static String singleCalls;

  Future setUpUDP() async {
    this.listIp.forEach((element) async {
      await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        this.port,
      ).then(
        (RawDatagramSocket udpSocket) {
          _udpSocket = udpSocket;
          udpSocket.listen((e) {
            switch (e) {
              case RawSocketEvent.read:
                _readDatagram();
                break;
              case RawSocketEvent.readClosed:
              case RawSocketEvent.closed:
                break;
            }
          });
          List<int> data = utf8.encode('share_app');

          udpSocket.send(
            data,
            element,
            this.port,
          );
        },
      );
    });
  }

  static Future openPortUdp(Share share) async {
    print("APRO");
    await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      2222,
    ).then(
      (RawDatagramSocket udpSocket) {
        udpSocket.listen((e) {
          switch (e) {
            case RawSocketEvent.read:
              if (udpSocket.receive().data == null) {
                return;
              }

              if (String.fromCharCodes(udpSocket.receive().data)
                  .contains(",")) {
                // Presenza parametro
              } else {
                List<int> data = utf8.encode(share
                    .find(String.fromCharCodes(udpSocket.receive().data)
                        .substring(6))
                    .function);

                udpSocket.send(
                  data,
                  InternetAddress("10.0.15.228"),
                  2222,
                );
              }
              break;
            case RawSocketEvent.readClosed:
            case RawSocketEvent.closed:
              break;
          }
        });
      },
    );
  }

  void _readDatagram() {
    Datagram datagram = _udpSocket.receive();

    print(String.fromCharCodes(datagram.data));

    if (datagram != null) {
      str.putIfAbsent(
        datagram.address,
        () => _setUpMib(
          datagram.address,
          String.fromCharCodes(datagram.data),
        ),
      );
    }
  }

  List<Mib> _setUpMib(InternetAddress ip, String rawString) {
    List<Mib> _listOfMib = new List<Mib>();
    RegExp _exp = new RegExp(r'(?<=")[^"]+(?=")');

    for (Match match in _exp.allMatches(rawString.replaceAll(",", ""))) {
      _listOfMib.add(
        new Mib(
          ip: ip,
          identify: match.group(0),
        ),
      );
    }

    return _listOfMib;
  }

  static Future<dynamic> callGraph(Mib mib, String param) async {
    await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      9999,
    ).then(
      (RawDatagramSocket udpSocket) {
        udpSocket.listen((e) {
          Datagram dg = udpSocket.receive();

          if (dg == null) {
            return;
          } else {
            graph.putIfAbsent(mib, () => [String.fromCharCodes(dg.data)]);
          }

          graph.update(mib, (value) {
            value.add(String.fromCharCodes(dg.data));
            return value;
          });
        });
        udpSocket.send(
          utf8.encode('mib, param = "${mib.identify}", "$param"'),
          mib.ip,
          9999,
        );
      },
    );
  }

  static Future<dynamic> callSingleValue(Mib mib, String param) async {
    await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      9999,
    ).then(
      (RawDatagramSocket udpSocket) {
        udpSocket.listen((e) {
          Datagram dg = udpSocket.receive();
          if (dg == null) {
            return;
          }
          print(String.fromCharCodes(dg.data));
          singleCalls = new String.fromCharCodes(dg.data);
        });
        udpSocket.send(
          utf8.encode('mib, param = "${mib.identify}", $param'),
          mib.ip,
          9999,
        );
      },
    );
  }
}
