import 'package:Share/models/service.dart';

class Share {
  final List<Service> services;

  Share(this.services);

  bool attach(Service service) {
    if (this.services.contains(service)) return false;
    this.services.add(service);
    return true;
  }

  bool detach(Service service) {
    return this.services.remove(service);
  }

  List<Service> find(String mib) {
    print("CERCO: "+mib.substring(0,mib.length-1));
    return this.services.where((serv) => serv.mib.startsWith(mib.substring(0,mib.length-1)));
  }
}
