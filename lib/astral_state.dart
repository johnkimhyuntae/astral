import 'dart:math';

import 'package:astral/log_data.dart';
import 'package:flutter/material.dart';


class AstralState extends ChangeNotifier {
  ScrollController controller = ScrollController();
  DateTime latestUpdatedTime;
  Map<String, String> statIdTitleMap;
  Map<String, String> statIdValueMap;
  List<LogData> logs;
  int currentPageIndex = 0;

  AstralState()
      : latestUpdatedTime = DateTime.now(),
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

  void updatePageIndex(int page) {
    currentPageIndex = page;
    notifyListeners();
  }

  void updateDateTime() {
    latestUpdatedTime = DateTime.now();
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
