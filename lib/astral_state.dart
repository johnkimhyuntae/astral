import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AstralState extends ChangeNotifier {
  DateTime currentDateTime;
  Map<String, String> statIdTitleMap;
  Map<String, String> statIdValueMap;

  AstralState()
      : currentDateTime = DateTime.now(),
        statIdTitleMap = {
          "wind-speed": "WIND SPEED",
        },
        statIdValueMap = {
          "wind-speed": "20 km/h",
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
