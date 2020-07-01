import 'dart:io';

import 'package:Share/models/mib_enum.dart';
import 'package:flutter/widgets.dart';

class Mib {
  InternetAddress ip;
  String identify;
  Mibs category;

  Mib({
    @required this.ip,
    @required this.identify,
    this.category = Mibs.UNKNOWN,
  });

  InternetAddress get addressMib {
    return ip;
  }

  String get deviceMib {
    return identify;
  }

  Mibs get categoryMib {
    return category;
  }

  void setIp(InternetAddress currentIp) {
    this.ip = currentIp;
  }

  void setId(String currentId) {
    this.identify = currentId;
  }

  void setCategory(Mibs currentCategory) {
    this.category = currentCategory;
  }

  Mibs checkCategory() {
    if (this.identify.startsWith("1.2.")) {
      return Mibs.MATHEMATICS;
    } else if (this.identify.startsWith("2.1.")) {
      return Mibs.TEMPERATURE;
    } else if (this.identify.startsWith("5.3.")) {
      return Mibs.BOILER;
    } else {
      return Mibs.UNKNOWN;
    }
  }

  Mib putInCategory() {
    return new Mib(
      ip: this.ip,
      identify: this.identify,
      category: checkCategory(),
    );
  }

  @override
  String toString() {
    return "[CATEGORY: ${this.category}][IP: ${this.ip.address}][MIB: ${this.identify}]\n";
  }
}
