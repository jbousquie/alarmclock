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

  Widget buildWakeUpTime(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final Clock clock = Provider.of<Clock>(context, listen: true);
    TimeOfDay wakeUpTime = clock.wakeUpTime;
    final formattedWakeUpTime =
        localizations.formatTimeOfDay(wakeUpTime, alwaysUse24HourFormat: true);

    final wakeUpTimeButton = TextButton(
        onPressed: () async {
          TimeOfDay? wkt = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay(hour: wakeUpTime.hour, minute: wakeUpTime.minute));
          clock.wakeUpTime = wkt ?? wakeUpTime;
        },
        child: Text(formattedWakeUpTime));
    return wakeUpTimeButton;
  }

  Widget buildContent(BuildContext context) {
    List<Widget> childrenList = [
      buildCurrentTime(context),
      buildWakeUpTime(context),
      buildBackButton(context)
    ];
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: childrenList,
        ));
  }
}
