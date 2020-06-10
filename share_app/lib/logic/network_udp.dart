import 'dart:convert';
import 'dart:io';

class NetworkController {
  final List<InternetAddress> ip;
  final int port;

  NetworkController({
    this.ip,
    this.port = 7878,
  });

  Map<InternetAddress, List<String>> _str =
      new Map<InternetAddress, List<String>>();

  void setUpUDP() {
    RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      this.port,
    ).then(
      (RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;
        udpSocket.listen((e) {
          Datagram dg = udpSocket.receive();
          if (dg != null) {
            buildStr(String.fromCharCodes(dg.data));
          }
        });
        List<int> data = utf8.encode('\n');

        this.ip.forEach((ip) {
          udpSocket.send(
            data,
            ip,
            this.port,
          );
        });
      },
    );
  }

  Map<InternetAddress, List<String>> getStructure() {
    return _str;
  }

  void buildStr(String data) {
    this.ip.forEach((ip) {
      _str.putIfAbsent(
        ip,
        () => setUpMib(data),
      );
    });
  }

  List<String> setUpMib(String mib) {
    List<String> _listOfMib = new List<String>();
    RegExp _exp = new RegExp(r'(?<=")[^"]+(?=")');

    for (Match match in _exp.allMatches(mib.replaceAll(",", ""))) {
      _listOfMib.add(match.group(0));
    }

    return _listOfMib;
  }
}
