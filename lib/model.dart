import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clock extends ChangeNotifier {
  static int intervalDuration = 1; // duration in sec between two timer recalls
  static int settingsPageDuration = 3; // Settings page timeout in sec
  late Timer timer;

  String timeString = '';
  String dateString = '';

  static int defaultWakeUpHour = 8;
  int wakeUpHour = defaultWakeUpHour;
  int wakeUpMinute = 0;
  TimeOfDay _wakeUpTime = TimeOfDay(hour: defaultWakeUpHour, minute: 0);

  Clock() {
    initializeDateFormatting('fr_FR', null).then((_) => updateTime());
    timer = Timer.periodic(Duration(seconds: intervalDuration), (timer) {
      updateTime();
    });
    restoreSettings();
  }

  TimeOfDay get wakeUpTime {
    return _wakeUpTime;
  }

  set wakeUpTime(TimeOfDay value) {
    _wakeUpTime = value;
    storeSettings();
    notifyListeners();
  }

  void updateTime() {
    final DateTime now = DateTime.now();
    timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(now);
    dateString = DateFormat('EEEE d MMMM', 'fr_FR').format(now);
    notifyListeners();
  }

  Future<void> restoreSettings() async {
    final prefs = await SharedPreferences.getInstance();
    wakeUpHour = prefs.getInt('wakeuphour') ?? wakeUpHour;
    wakeUpMinute = prefs.getInt('wakeupminute') ?? wakeUpMinute;
    wakeUpTime = TimeOfDay(hour: wakeUpHour, minute: wakeUpMinute);
  }

  Future<void> storeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    wakeUpHour = wakeUpTime.hour;
    wakeUpMinute = wakeUpMinute;
    await prefs.setInt('wakeuphour', wakeUpHour);
    await prefs.setInt('wakeupminute', wakeUpMinute);
  }
}
