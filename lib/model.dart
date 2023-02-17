import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class Clock extends ChangeNotifier {
  static int intervalDuration = 1; // duration in seconds between two timer recalls
  late Timer timer;

  String timeString = '';

  Clock() {
    timer = Timer.periodic(Duration(seconds: intervalDuration), (timer) {
      updateTime();
    });
    updateTime();
  }

  void updateTime() {
    final DateTime now = DateTime.now();

    timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(now);
    notifyListeners();
  }
}
