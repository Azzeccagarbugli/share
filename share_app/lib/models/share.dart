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
}
