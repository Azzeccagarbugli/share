import 'package:Share/widgets/effects/shadow.dart';
import 'package:flutter/material.dart';

class CardSettings extends StatelessWidget {
  const CardSettings({
    Key key,
    @required this.onTap,
    this.title,
    this.subtitle,
    this.icon,
  }) : super(key: key);

  final Function onTap;

  final String title;
  final String subtitle;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: Neumorphism.boxShadow(context),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.fade,
        ),
        leading: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: Neumorphism.boxShadow(context),
            color: Colors.white,
          ),
          child: icon,
        ),
      ),
    );
  }
}
