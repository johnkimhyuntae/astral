import 'dart:math';

import 'package:astral/log_data.dart';
import 'time_weather_info_card.dart';
import 'weather_info_card.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';
import 'API_handler.dart';

class AstralState extends ChangeNotifier {
  ScrollController controller = ScrollController();
  DateTime latestUpdatedTime;

  double lat = 52.1951;
  double lon = 0.1313;

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
    API_caller API_instance = API_caller();
    Future<Album> futureAlbum = API_instance.callAPI(lat, lon);
    futureAlbum.then((weatherAlbum) {
      statIdValueMap["time"] = weatherAlbum.time[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[latestUpdatedTime.hour].toString();

      notifyListeners();
    });


    //statIdValueMap["wind-speed"] = "${Random().nextInt(30)}";
    //notifyListeners();
  }

  void updateLocation(String newLocation) {
    Future<List<double>> futureLatLon = API_handler.fetchLatLon(newLocation);
    futureLatLon.then((latLon) {
      lat = latLon[0];
      lon = latLon[1];
      updateWeather();
    });
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
