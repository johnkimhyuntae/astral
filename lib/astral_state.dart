import 'dart:math';

import 'package:astral/log_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class AstralState extends ChangeNotifier {
  ScrollController? controller;
  DateTime currentDateTime;
  Map<String, String> statIdTitleMap;
  Map<String, String> statIdValueMap;
  List<LogData> logs;

  AstralState()
      : currentDateTime = DateTime.now(),
        logs = [],
        statIdTitleMap = {
          "wind-speed": "Wind Speed",
          "wind-direction": "Wind Direction",
        },
        statIdValueMap = {
          "wind-speed": "20 km/h",
          "wind-direction": "NE",
        }
  ;

  void updateDateTime() {
    currentDateTime = DateTime.now();
    notifyListeners();
  }

  void updateWeather() {
    // TODO: API Call
    statIdValueMap["wind-speed"] = "${Random().nextInt(30)}";
    notifyListeners();
  }
  void addNewLog(LogData x) {
    for (LogData y in logs) {
      if (x.id == y.id) {
        return;
      }
      else {
        logs.add(x);
      }
    }
  }
  void removeLog(LogData x) {
    logs.remove(x);
    return;
  }
}
