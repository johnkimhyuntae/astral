// import 'dart:convert';      // required to encode/decode json data
// import 'package:http/http.dart' as http;
//
// class Post {
//   int? albumId;
//   int? id;
//   String? title;
//   String? url;
//   String? thumbnailUrl;
//
//   Post({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});
//
//   Post.fromJson(Map<String, dynamic> json) {
//     albumId = json['albumId'];
//     id = json['id'];
//     title = json['title'];
//     url = json['url'];
//     thumbnailUrl = json['thumbnailUrl'];
//   }
//
//   static Future<List<Post>> getPosts() async {
//     var url = Uri.parse("https://my.meteoblue.com/packages/basic-1h_basic-day?lat=47.558&lon=7.573&asl=279&tz=Europe%2FZurich&name=Basel&format=json&history_days=1&apikey=DEMOKEY&sig=3413036bf33758dd1cc57596bf520ca0");
//     final response = await http.get(url, headers: {"Content-Type": "application/json"});
//     final List body = json.decode(response.body);
//     return body.map((e) => Post.fromJson(e)).toList();
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

//import 'package:rest_api_example/model/user_model.dart';
//import 'package:rest_api_example/services/api_service.dart';

class API_caller {
  var futureAlbum = null;
  callAPI(lat, lon) {
    return API_handler.fetchAlbum(lat, lon);
  }
}

class API_handler {
  // Future<List<UserModel>?> getUsers() async {
  //   try {
  //     var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       List<UserModel> _model = userModelFromJson(response.body);
  //       return _model;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  static Future<List<double>> fetchLatLon(location) async {
    print('Starting Location API call');
    final response = await http.get(Uri.parse('https://www.meteoblue.com/en/server/search/query3?query=$location&apikey=A0fdQ5eDnNypHMTZ'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      LatLon localLatLon = LatLon.getLatLon(jsonDecode(response.body) as Map<String, dynamic>);
      // converting LatLon object into a list of doubles of size 2
      List<double> latLonList = [localLatLon.lat, localLatLon.lon];
      return latLonList;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Album> fetchAlbum(lat, lon) async {
    print('Starting Weather API call');
    final response = await http.get(Uri.parse('https://my.meteoblue.com/packages/basic-1h_basic-day_clouds-1h?apikey=A0fdQ5eDnNypHMTZ&lat=$lat&lon=$lon&asl=279&format=json'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class LatLon {
  final double lat;
  final double lon;

  const LatLon({
    required this.lat,
    required this.lon,
  });

  factory LatLon.getLatLon(Map<String, dynamic> json) {
    print(json);
    return LatLon(lat: json['lat'] as double, lon: json['lon'] as double);
  }
}

class Album {
  final Metadata metadata;
  final Units units;

  final List<double> windspeed;
  final List<String> time;
  final List<double> temperature;
  final List<double> felttemperature;
  final List<int> relativehumidity;
  final List<int> winddirection;
  final List<int> precipitation_percentage;
  final List<int> cloud_percentage;

  const Album({
    required this.metadata,
    required this.units,

    required this.windspeed,
    required this.time,
    required this.temperature,
    required this.felttemperature,
    required this.relativehumidity,
    required this.winddirection,
    required this.precipitation_percentage,
    required this.cloud_percentage,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    print(json);
    return Album(
      metadata: Metadata.fromJson(json['metadata']),
      units: Units.fromJson(json['units']),

      windspeed: List<double>.from(json['data_1h']['windspeed']),
      time: List<String>.from(json['data_1h']['time']),
      temperature: List<double>.from(json['data_1h']['temperature']),
      felttemperature: List<double>.from(json['data_1h']['felttemperature']),
      relativehumidity: List<int>.from(json['data_1h']['relativehumidity']),
      winddirection: List<int>.from(json['data_1h']['winddirection']),
      precipitation_percentage: List<int>.from(json['data_1h']['precipitation_probability']),
      cloud_percentage: List<int>.from(json['data_1h']['highclouds']),

    );
  }
}

class Metadata {
  final String modelrunUpdatetimeUtc;
  final String name;
  final int height;
  final String timezoneAbbreviation;
  final double latitude;
  final String modelrunUtc;
  final double longitude;
  final double utcTimeoffset;
  final double generationTimeMs;

  Metadata({
    required this.modelrunUpdatetimeUtc,
    required this.name,
    required this.height,
    required this.timezoneAbbreviation,
    required this.latitude,
    required this.modelrunUtc,
    required this.longitude,
    required this.utcTimeoffset,
    required this.generationTimeMs,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      modelrunUpdatetimeUtc: json['modelrun_updatetime_utc'],
      name: json['name'],
      height: json['height'],
      timezoneAbbreviation: json['timezone_abbrevation'],
      latitude: json['latitude'],
      modelrunUtc: json['modelrun_utc'],
      longitude: json['longitude'],
      utcTimeoffset: json['utc_timeoffset'],
      generationTimeMs: json['generation_time_ms'],
    );
  }
}

class Units {
  final String predictability;
  final String precipitation;
  final String windspeed;
  final String precipitationProbability;
  final String relativeHumidity;
  final String temperature;
  final String time;
  final String pressure;
  final String windDirection;

  Units({
    required this.predictability,
    required this.precipitation,
    required this.windspeed,
    required this.precipitationProbability,
    required this.relativeHumidity,
    required this.temperature,
    required this.time,
    required this.pressure,
    required this.windDirection,
  });

  factory Units.fromJson(Map<String, dynamic> json) {
    return Units(
      predictability: json['predictability'],
      precipitation: json['precipitation'],
      windspeed: json['windspeed'],
      precipitationProbability: json['precipitation_probability'],
      relativeHumidity: json['relativehumidity'],
      temperature: json['temperature'],
      time: json['time'],
      pressure: json['pressure'],
      windDirection: json['winddirection'],
    );
  }
}