import 'dart:math';

import 'package:flutter/material.dart';

class AstralState extends ChangeNotifier {
  ScrollController controller = ScrollController();
  DateTime currentDateTime;
  Map<String, String> statIdTitleMap;
  Map<String, String> statIdValueMap;

  AstralState()
      : currentDateTime = DateTime.now(),
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
}
