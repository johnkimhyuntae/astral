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
    WType.feltTemperature: "Feels Like",
    WType.fogPercentage: "Fog",
    WType.humidity: "Humidity",
    WType.precipitation: "Rainfall",
    WType.precipitationPercentage: "Precipitation",
    WType.sunshineMinutes: "Sunshine",
    WType.temperature: "Temperature",
    WType.uvIndex: "UV Index",
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

  // "About" descriptions for each wType
  Map<WType, String> statIdAboutMap = {
    WType.windSpeed: "The wind speed is calculated using the average over a short period of time. Gusts are short bursts of wind above this average. A gust typically lasts under 20 seconds.",
    WType.feltTemperature: "The temperature is the average over a short period of time. The 'Feels Like' temperature is the temperature perceived by humans, taking into account wind speed and humidity.",
    WType.cloudPercentage: "The cloud cover is the fraction of the sky covered by clouds. A value of 0% means the sky is clear, while 100% means the sky is completely overcast.",
    WType.fogPercentage: "The fog percentage is the likelihood of fog forming. A value of 0% means no fog, while 100% means fog is certain.",
    WType.humidity: "The humidity is the amount of water vapour in the air. A value of 0% means the air is completely dry, while 100% means the air is completely saturated.",
    WType.precipitation: "The precipitation is the amount of rain or snow that falls in a given time period. A value of 0mm means no precipitation, while 100mm means a very heavy downpour.",
    WType.precipitationPercentage: "The precipitation percentage is the likelihood of precipitation occurring. A value of 0% means no precipitation, while 100% means precipitation is certain.",
    WType.sunshineMinutes: "The sunshine minutes is the amount of time the sun is visible in a given time period. A value of 0 minutes means no sunshine, while 60 minutes means the sun is visible for the entire hour.",
    WType.temperature: "The temperature is the average over a short period of time. It is measured in degrees Celsius.",
    WType.uvIndex: "The UV index is a measure of the strength of the sun's ultraviolet radiation. A value of 0 means low risk of harm from unprotected sun exposure, while 11+ means extreme risk of harm.",
    WType.visibility: "The visibility is the distance at which objects can be clearly seen. A value of 0km means no visibility, while 10km means excellent visibility.",
    WType.windDirection: "The wind direction is the direction from which the wind is blowing. It is measured in compass directions.",
    WType.moonrise: "The moonrise is the time at which the moon first becomes visible above the horizon.",
    WType.moonset: "The moonset is the time at which the moon last becomes visible above the horizon.",
    WType.moonPhase: "The moon phase is the shape of the illuminated portion of the moon as seen from Earth. The different phases are new moon, waxing crescent, first quarter, waxing gibbous, full moon, waning gibbous, last quarter, and waning crescent.",
    WType.sunrise: "The sunrise is the time at which the sun first becomes visible above the horizon.",
    WType.sunset: "The sunset is the time at which the sun last becomes visible above the horizon.",
  };

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
        daily.map((e) => (e as String)).toList();
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

  List<String> turnToCapitalAtStart(List<String> vals) {
    List<String> newVals = [];
    for (String val in vals) {
      val = val.substring(0, 1).toUpperCase() +
          val.substring(1, val.length).toLowerCase();
      for (int i = 1; i < val.length; i++) {
        if ((val.substring(i, i + 1) == " ") && (i + 1 != val.length) && (i + 2 != val.length)) {
          val =
              val.substring(0, i + 1) + val.substring(i + 1, i + 2).toUpperCase() +
                  val.substring(i + 2, val.length);
        }
      }
      newVals.add(val);
    }
    return newVals;
  }

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
        turnToCapitalAtStart(weatherData.dailyData.moonphasename.map((x) => x as String).toList() as List<String>),
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
            "North",
            "North-East",
            "East",
            "South-East",
            "South",
            "South-West",
            "West",
            "North-West"
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
      widget: WeatherInfoCard(WType.moonPhase),
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
      widget: WeatherInfoCard(WType.moonrise),
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
      widget: WeatherInfoCard(WType.moonset),
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
      key: Key("N"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonPhase),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("O"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonrise),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("P"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.moonset),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("Q"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.sunrise),
    ),
    const ReorderableStaggeredScrollViewGridCountItem(
      key: Key("R"),
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      widget: WeatherInfoCard(WType.sunset),
    ),
  ];
}
