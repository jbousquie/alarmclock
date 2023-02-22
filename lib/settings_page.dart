import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  const SettingsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    Widget mat = Material(
      child: buildContent(context),
    );
    return mat;
  }

  Widget buildCurrentTime(BuildContext context) {
    final Clock clock = Provider.of<Clock>(context, listen: true);
    final timeString = clock.timeString;
    final Text timeWidget = Text(timeString);
    return timeWidget;
  }

  Widget buildBackButton(BuildContext context) {
    final BackButton bb = BackButton(
      onPressed: () => Navigator.pop(context),
    );
    return bb;
  }

  Widget buildContent(BuildContext context) {
    List<Widget> childrenList = [
      buildCurrentTime(context),
      buildBackButton(context)
    ];
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: childrenList,
        ));
  }
}
