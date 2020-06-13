import 'dart:convert';
import 'dart:io';

class NetworkController {
  final List<InternetAddress> listIp;
  final int port;

  NetworkController({
    this.listIp,
    this.port = 7878,
  });

  RawDatagramSocket _udpSocket;

  Map<InternetAddress, List<String>> str =
      new Map<InternetAddress, List<String>>();

  Future setUpUDP() async {
    this.listIp.forEach((element) async {
      await RawDatagramSocket.bind(
        InternetAddress.anyIPv4,
        this.port,
      ).then(
        (RawDatagramSocket udpSocket) {
          _udpSocket = udpSocket;
          udpSocket.broadcastEnabled = true;
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

  void _readDatagram() {
    Datagram datagram = _udpSocket.receive();

    print(String.fromCharCodes(datagram.data));

    if (datagram != null) {
      str.putIfAbsent(
        datagram.address,
        () => _setUpMib(
          String.fromCharCodes(datagram.data),
        ),
      );
    }
  }

  List<String> _setUpMib(String mib) {
    List<String> _listOfMib = new List<String>();
    RegExp _exp = new RegExp(r'(?<=")[^"]+(?=")');

    for (Match match in _exp.allMatches(mib.replaceAll(",", ""))) {
      _listOfMib.add(match.group(0));
    }

    return _listOfMib;
  }
}
