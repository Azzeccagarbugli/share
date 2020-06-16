import 'package:Share/widgets/card_header.dart';
import 'package:Share/widgets/card_settings.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          BuildCardHeader(),
          CardSettings(
            onTap: () {},
            title: "GitHub",
            subtitle:
                "All the code is available on GitHub, just go to chek it out!",
            icon: Icon(
              Icons.exit_to_app,
            ),
          ),
          CardSettings(
            onTap: () {},
            title: "Information",
            subtitle:
                "Discover more about this project and learn more about the developed pattern",
            icon: Icon(
              Icons.link,
            ),
          ),
        ],
      ),
    );
  }
}
