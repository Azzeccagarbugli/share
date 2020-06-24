import 'package:Share/models/service.dart';

import 'mib.dart';

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

  Service find(String mib) {
    return this.services.where((serv) => serv.mib == mib).single;
  }
}
