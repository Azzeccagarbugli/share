import 'package:Share/models/service.dart';

class Share {
  List<Service> services;

  Share(this.services);

  bool attach(Service service) {
    if (this.services.contains(service)) return false;
    this.services.add(service);
    return true;
  }

  bool detach(Service service) {
    return this.services.remove(service);
  }

  String find(String mib) {
    String tab = "{";
    this
        .services
        .where((serv) => serv.mib.startsWith(mib.substring(0, mib.length - 1)))
        .forEach((element) {
      if (this.services.indexOf(element) == this.services.length - 1) {
        tab += '"$element"';
      } else
        tab += '"$element",';
    });
    tab += "}";
    return tab;
  }

  Service getService(String mib) {
    return this.services.where((element) => element.mib == mib).single;
  }
}
