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

  Mib putInCategory() {
    Mib newMib = new Mib(ip: this.ip, identify: this.identify);

    if (this.identify.startsWith("1.2.")) {
      newMib.setCategory(Mibs.MATHEMATICS);
    } else if (this.identify.startsWith("2.1.")) {
      newMib.setCategory(Mibs.TEMPERATURE);
    } else {
      newMib.setCategory(Mibs.UNKNOWN);
    }

    return newMib;
  }
}
