import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'API_handler.dart';

class AstralState extends ChangeNotifier {
  DateTime currentDateTime;
  Map<String, String> statIdTitleMap;
  Map<String, String> statIdValueMap;

  double lat = 52.1951;
  double lon = 0.1313;

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
    API_caller API_instance = API_caller();
    Future<Album> futureAlbum = API_instance.callAPI(lat, lon);
    futureAlbum.then((weatherAlbum) {
      statIdValueMap["time"] = weatherAlbum.time[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();
      statIdValueMap["wind-speed"] = weatherAlbum.windspeed[currentDateTime.hour].toString();

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
}
