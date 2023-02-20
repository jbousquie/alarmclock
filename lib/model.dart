import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clock extends ChangeNotifier {
  static int intervalDuration = 1; // duration in seconds between two timer recalls
  late Timer timer;

  String timeString = '';
  String dateString = '';

  Clock() {
    initializeDateFormatting('fr_FR', null).then((_) => updateTime());
    timer = Timer.periodic(Duration(seconds: intervalDuration), (timer) {
      updateTime();
    });
  }

  void updateTime() {
    final DateTime now = DateTime.now();

    timeString = DateFormat(DateFormat.HOUR24_MINUTE_SECOND).format(now);
    dateString = DateFormat('EEEE d MMMM', 'fr_FR').format(now);
    notifyListeners();
  }
}
