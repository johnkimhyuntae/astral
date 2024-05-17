import 'dart:math';

import 'package:astral/log_data.dart';
import 'time_weather_info_card.dart';
import 'weather_info_card.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

class AstralState extends ChangeNotifier {
  ScrollController controller = ScrollController();
  DateTime latestUpdatedTime;
  Map<String, String> statIdTitleMap = {
    "wind-speed": "Wind Speed",
    "wind-direction": "Wind Direction",
  };
  Map<String, String> statIdValueMap = {
    "wind-speed": "20 km/h",
    "wind-direction": "NE",
  };
  List<LogData> logs = [];
  int currentPageIndex = 0;
  AstralState() : latestUpdatedTime = DateTime.now();

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
      } else {
        logs.add(x);
      }
    }
  }

  void removeLog(LogData x) {
    logs.remove(x);
    return;
  }

  var weatherInfoWidgetsList = [
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("A"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard("wind-speed"),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("B"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard("wind-direction"),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("C"),
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      widget: TimeWeatherInfoCard(),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("D"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard("wind-speed"),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("E"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard("wind-speed"),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("F"),
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      widget: WeatherInfoCard("wind-speed"),
    ),
  ];
}
