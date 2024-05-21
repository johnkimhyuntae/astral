import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

import 'api_handler.dart';
import 'log_data.dart';
import 'time_weather_info_card.dart';
import 'weather_info_card.dart';
import 'weather_info_type.dart';

class AstralState extends ChangeNotifier {
  DateTime latestUpdatedTime = DateTime.now();

  double lat = 52.2029;
  double lon = 0.1179;

  Map<WType, String> statIdTitleMap = {
    WType.cloudPercentage: "Cloud Cover",
    WType.feltTemperature: "Feels like",
    WType.fogPercentage: "Fog",
    WType.humidity: "Humidity",
    WType.precipitation: "Rainfall",
    WType.precipitationPercentage: "Precipitation",
    WType.sunshineMinutes: "Sunshine",
    WType.temperature: "Temperature",
    WType.uvIndex: "Uv Index",
    WType.visibility: "Visibility",
    WType.windDirection: "Wind Direction",
    WType.windSpeed: "Wind Speed",
    WType.moonrise: "Moonrise",
    WType.moonset: "Moonset",
    WType.moonPhase: "Moon Phase",
    WType.sunrise: "Sunrise",
    WType.sunset: "Sunset",
  };
  Map<WType, List<List<String>>> statIdValueMapHourly = {};
  Map<WType, List<String>> statIdValueMapDailyAverage = {};

  APIData? apiData;

  AstralState() {
    updateWeather();
  }

  clearData(){
    for (var t in WType.values) {
      statIdValueMapHourly[t] = [];
      statIdValueMapDailyAverage[t] = [];
    }
    List<String> day = [];
    for (int j = 0; j < 24; j++) {
      day.add("⟳");
    }
    for (int i = 0; i < 7; i++) {
      for (var t in WType.values) {
        statIdValueMapHourly[t]!.add(day);
        statIdValueMapDailyAverage[t]!.add("⟳");
      }
    }
    notifyListeners();
  }

  List<LogData> logs = [];

  int currentDayIndex = 0;

  void updatePageIndex(int page) {
    currentDayIndex = page;
    notifyListeners();
  }

  void parseAstro<T>(
      WType type,
      List daily) {
    statIdValueMapDailyAverage[type] =
        daily.map((e) => (e as String).toUpperCase()).toList();
  }

  void parseType<T>(
    String Function(T) parse,
    String unit,
    WType type,
    DailyHourly data, [
    List? daily,
  ]) {
    statIdValueMapHourly[type] = data
        .map((day) => day.map((e) => "${parse(e)}$unit").toList())
        .toList();
    if (daily != null) {
      statIdValueMapDailyAverage[type] =
          daily.map((e) => "${parse(e)}$unit").toList();
    }
    else {
      List<String> avg = [];
      for (int i = 0; i < 7; i++) {
          avg.add("${parse(data[i][DateTime.now().hour])}$unit");
        }

      statIdValueMapDailyAverage[type] = avg;
    }
  }

  void updateLocation(String newLocation) {
    var futureLatLon = APIHandler.fetchLatLon(newLocation);
    futureLatLon.then(
      (latLon) {
        if (latLon == null) return;
        lat = latLon.lat;
        lon = latLon.lon;
        locationController.text = latLon.loc;
        updateWeather();
      },
    );
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

  void removeLog(String requestedId) {
    for (LogData entry in logs) {
      if (entry.id == requestedId) {
        logs.remove(entry);
        notifyListeners();
      }
    }
    return;                   
  }

  DateTime getLatestTime() {
    return latestUpdatedTime;
  }

  ScrollController scrollController = ScrollController();
  TextEditingController locationController =
      TextEditingController(text: "Cambridge, UK");

  void updateWeather() {
    clearData();
    APIHandler.fetchWeatherData(lat, lon).then((weatherData) {
      apiData = weatherData;

      parseType(
            (value) {
          String s = value as String;
          var dt = DateTime.parse(s);
          return s;
        },
        "",
        WType.time,
        weatherData.hourlyData.time,
        weatherData.dailyData.time,
      );

      parseType(
            (value) {
              return "${value as int}";
        },
        "%",
        WType.fogPercentage,
        weatherData.hourlyData.fog_probability,
      );

      parseType(
            (value) {
              return "${value as int}";
        },
        " mins",
        WType.sunshineMinutes,
        weatherData.hourlyData.sunshinetime,
      );

      parseType(
        (value) {
          return ((value as double) * 3.6).toStringAsPrecision(3); // ms^-1 -> kmph
        },
        " km/h",
        WType.windSpeed,
        weatherData.hourlyData.windspeed,
        weatherData.dailyData.windspeed_mean,
      );

      parseType(
        (value) {
          return ((value as double)).toStringAsFixed(0);
        },
        " °C",
        WType.temperature,
        weatherData.hourlyData.temperature,
        weatherData.dailyData.temperature_mean,
      );

      parseType(
        (value) {
          return ((value as double)).toStringAsFixed(0);
        },
        " °C",
        WType.feltTemperature,
        weatherData.hourlyData.felttemperature,
        weatherData.dailyData.felttemperature_mean,
      );

      parseType(
            (value) {
          return "${(value as int) ~/ 1000}";
        },
        " km",
        WType.visibility,
        weatherData.hourlyData.visibility,
      );

      parseType(
            (value) {
          return "${value as int}";
        },
        "",
        WType.uvIndex,
        weatherData.hourlyData.uvindex,
        weatherData.dailyData.uvindex,
      );

      parseType(
        (value) {
          return "${value as int}";
        },
        "%",
        WType.humidity,
        weatherData.hourlyData.relativehumidity,
        weatherData.dailyData.relativehumidity_mean,
      );

      parseType(
        (value) {
          return (value as double).toStringAsPrecision(3);
        },
        " mm",
        WType.precipitation,
        weatherData.hourlyData.precipitation,
        weatherData.dailyData.precipitation,
      );

      parseAstro(
        WType.moonrise,
        weatherData.dailyData.moonrise,
      );

      parseAstro(
        WType.moonset,
        weatherData.dailyData.moonset,
      );

      parseAstro(
        WType.moonPhase,
        weatherData.dailyData.moonphasename,
      );

      parseAstro(
        WType.sunrise,
        weatherData.dailyData.sunrise,
      );

      parseAstro(
        WType.sunset,
        weatherData.dailyData.sunset,
      );

      parseType(
            (value) {
          return (value as int).toString();
        },
        "%",
        WType.precipitationPercentage,
        weatherData.hourlyData.precipitation_probability,
        weatherData.dailyData.precipitation_probability,
      );

      parseType(
        (value) {
          return "${value as int}";
        },
        "%",
        WType.cloudPercentage,
        weatherData.hourlyData.totalcloudcover,
      );

      parseType(
        (value) {
          final compassDirections = [
            "N",
            "NE",
            "E",
            "SE",
            "S",
            "SW",
            "W",
            "NW"
          ];
          return compassDirections[min(((value as int) + 22) ~/ 45, 7)];
        },
        "",
        WType.windDirection,
        weatherData.hourlyData.winddirection,
        weatherData.dailyData.winddirection,
      );

      latestUpdatedTime = DateTime.now();
      notifyListeners();
    });
  }

  var weatherInfoWidgetsList = [
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("A"),
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      widget: TimeWeatherInfoCard(WType.temperature),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("N"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonPhase, expandable: false),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("B"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.cloudPercentage),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("O"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonrise, expandable: false),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("D"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.fogPercentage),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("P"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonset, expandable: false),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("C"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.feltTemperature),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("J"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.uvIndex),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("H"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.sunshineMinutes),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("E"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.humidity),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("F"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.precipitation),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("G"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.precipitationPercentage),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("K"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.visibility),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("L"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.windDirection),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("M"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.windSpeed),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("Q"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.sunrise, expandable: false),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("R"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.sunset, expandable: false),
    ),
  ];
}
