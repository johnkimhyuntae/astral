import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

import 'API_handler.dart';
import 'log_data.dart';
import 'time_weather_info_card.dart';
import 'weather_info_card.dart';
import 'weather_info_type.dart';

class AstralState extends ChangeNotifier {
  DateTime latestUpdatedTime = DateTime.now();

  double lat = 52.1951;
  double lon = 0.1313;

  Map<WType, String> statIdTitleMap = {
    WType.windSpeed: "Wind Speed",
    WType.windDirection: "Wind Direction",
  };
  Map<WType, String> statIdValueMap = {
    WType.windSpeed: "20 km/h",
    WType.windDirection: "NE",
  };

  List<LogData> logs = [];

  int currentPageIndex = 0;

  AstralState() {
    updateWeather();
  }

  void updatePageIndex(int page) {
    currentPageIndex = page;
    notifyListeners();
  }

  void updateDateTime() {
    latestUpdatedTime = DateTime.now();
    notifyListeners();
  }

  void updateWeather() {
    API_caller apiInstance = API_caller();
    Future<Album> futureAlbum = apiInstance.callAPI(lat, lon);
    futureAlbum.then((weatherAlbum) {
      // TODO: Parse time
      // latestUpdatedTime = weatherAlbum.time[latestUpdatedTime.hour];
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();
      statIdValueMap[WType.windSpeed] =
          weatherAlbum.windspeed[latestUpdatedTime.hour].toString();

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

  ScrollController scrollController = ScrollController();
  TextEditingController locationController =
      TextEditingController(text: "Cambridge, UK");

  var weatherInfoWidgetsList = [
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("A"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.windSpeed),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("B"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.windDirection),
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
      widget: WeatherInfoCard(WType.windSpeed),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("E"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.windSpeed),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("F"),
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      widget: WeatherInfoCard(WType.windSpeed),
    ),
  ];
}
