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
      //time
      statIdValueMapHourly["time"] = convertTo2DArrayOfStrings(weatherAlbum.time, "");
      statIdValueMapDailyAverage["time"] = convertToDailyAverages(weatherAlbum.time, "");
      //wind speed
      statIdValueMapHourly["wind-speed"] = convertTo2DArrayOfStrings(weatherAlbum.windspeed, "km/h");
      statIdValueMapDailyAverage["wind-speed"] = convertToDailyAverages(weatherAlbum.windspeed, "km/h");
      //wind direction
      List<int> windDirectionsBearings = weatherAlbum.winddirection;
      List<String> windDirections = [];
      for (var i = 0; i < windDirectionsBearings.length; i++) {
        windDirections.add(bearingToCompass(windDirectionsBearings[i]));
      }
      statIdValueMapHourly["wind-direction"] = convertTo2DArrayOfStrings(windDirections, "");
      statIdValueMapDailyAverage["wind-direction"] = convertToDailyAverages(windDirections, "");
      //temperature
      statIdValueMapHourly["temperature"] = convertTo2DArrayOfStrings(weatherAlbum.temperature, "°C");
      statIdValueMapDailyAverage["temperature"] = convertToDailyAverages(weatherAlbum.temperature, "°C");
      //felt temperature
      statIdValueMapHourly["felt-temperature"] = convertTo2DArrayOfStrings(weatherAlbum.felttemperature, "°C");
      statIdValueMapDailyAverage["felt-temperature"] = convertToDailyAverages(weatherAlbum.felttemperature, "°C");
      //humidity
      statIdValueMapHourly["humidity"] = convertTo2DArrayOfStrings(weatherAlbum.relativehumidity, "g/kg");
      statIdValueMapDailyAverage["humidity"] = convertToDailyAverages(weatherAlbum.relativehumidity, "g/kg");
      //precipitation percentage
      statIdValueMapHourly["precipitation-percentage"] = convertTo2DArrayOfStrings(weatherAlbum.precipitation_percentage, "%");
      statIdValueMapDailyAverage["precipitation-percentage"] = convertToDailyAverages(weatherAlbum.precipitation_percentage, "%");
      //cloud percentage
      statIdValueMapHourly["cloud-percentage"] = convertTo2DArrayOfStrings(weatherAlbum.cloud_percentage, "%");
      statIdValueMapDailyAverage["cloud-percentage"] = convertToDailyAverages(weatherAlbum.cloud_percentage, "%");

      notifyListeners();
    });


    //statIdValueMap["wind-speed"] = "${Random().nextInt(30)}";
    //notifyListeners();
  }

  String bearingToCompass(int bearing) {
    List<String> compassDirections = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"];
    return compassDirections[(bearing + 22) ~/ 45];
  }

  List<List<String>> convertTo2DArrayOfStrings<T>(List<T> originalData, String units) {
    List<List<String>> returnValue = [[], [], [], [], [], [], []];
    for (var i = 0; i < 168; i++) {
      returnValue[i ~/ 7].add(originalData[i].toString() + " " + units);
    }
    return returnValue;
  }

  List<String> convertToDailyAverages<T>(List<T> originalData, String units) {
    List<String> dailyAverages = [];
    for (var i = 0; i < 7; i++) {
      double total = 0;
      for (var j = 0; j < 24; j++) {
        total += originalData as num;
      }
      dailyAverages.add((total / 24).toStringAsPrecision(3) + " " + units);
    }
    return dailyAverages;
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

  DateTime getLatestTime() {
    return latestUpdatedTime;
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
