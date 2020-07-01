import 'package:Share/models/mib_enum.dart';
import 'package:Share/widgets/add_service_local.dart';
import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryCard extends StatelessWidget {
  final Mibs mib;
  final int devices;

  const CategoryCard({
    Key key,
    this.mib,
    this.devices,
  }) : super(key: key);

  String _stringFromMib(Mibs mib) {
    switch (mib) {
      case Mibs.MATHEMATICS:
        return "Mathematics";
      case Mibs.TEMPERATURE:
        return "Temperature";
      case Mibs.BOILER:
        return "Boiler";
      case Mibs.UNKNOWN:
        return "Unknown";
      default:
        return null;
    }
  }

  String _subtitileFromMib(Mibs mib) {
    switch (mib) {
      case Mibs.MATHEMATICS:
        return "Do your calculations!";
      case Mibs.TEMPERATURE:
        return "Is hot or cold?";
      case Mibs.BOILER:
        return "Your comfort starts now";
      case Mibs.UNKNOWN:
        return "We don't know these devices";
      default:
        return null;
    }
  }

  Widget _buildImgFromMib(Mibs mib) {
    String path = "assets/images/";
    switch (mib) {
      case Mibs.MATHEMATICS:
        path += "math.svg";
        break;
      case Mibs.TEMPERATURE:
        path += "temp.svg";
        break;
      case Mibs.BOILER:
        path += "com.svg";
        break;
      case Mibs.UNKNOWN:
        path += "404.svg";
        break;
      default:
        return null;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: new SvgPicture.asset(
        path,
        alignment: Alignment.bottomRight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return mib == Mibs.UNKNOWN
        ? MiniCard(
            text:
                "Discover the services that do not belong to any known category",
            icon: Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.white,
            ),
            boolWaves: false,
            onTap: () {},
          )
        : Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: Neumorphism.boxShadow(context),
              color: Colors.white,
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  bottom: -18,
                  left: 0,
                  right: 0,
                  child: _buildImgFromMib(mib),
                ),
                Positioned(
                  top: 58,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(16),
                    ),
                    child: ClipPath(
                      clipper: WaveClipperTwo(
                        reverse: true,
                      ),
                      child: Container(
                        color: Colors.purple[900],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 14,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _stringFromMib(mib),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _subtitileFromMib(mib),
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[200],
                    radius: 26,
                    child: Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 8,
                  child: Chip(
                    elevation: 6,
                    backgroundColor: Colors.white,
                    label: Text(
                      devices != 1 ? "Devices" : "Device",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    avatar: CircleAvatar(
                      child: Text(
                        devices.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
