import 'dart:convert';

import 'package:http/http.dart' as http;

class APIHandler {
  static Future<({double lat, double lon, String loc})?> fetchLatLon(
      location) async {
    print('Starting Location API call');
    var uri = Uri.https("www.meteoblue.com", "/en/server/search/query3", {
      "query": location, // prevent injection
      "apikey": "A0fdQ5eDnNypHMTZ",
    },);
    print(uri);
    final response = await http.get(uri);
    print('Received Location API response');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      try {
        var latLon = json["results"][0];
        return (
          lat: latLon['lat'] as double,
          lon: latLon['lon'] as double,
          loc: latLon["name"] as String,
        );
      } catch (_) {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<APIData> fetchWeatherData(lat, lon) async {
    print('Starting Weather API call');
    var uri = Uri.https(
      "my.meteoblue.com",
      "packages/basic-1h_basic-day_clouds-1h",
      {
        "apikey": "rsnRE5HetBLjY4TN",
        "lat": lat.toString(),
        "lon": lon.toString(),
        "asl": "279",
        "format": "json",
      },
    );
    print(uri);
    final expansiveResponse = await http.get(uri);
    print('Received Weather API response');
    uri = Uri.https(
      "my.meteoblue.com",
      "packages/basic-1h_sunmoon",
      {
        "apikey": "rsnRE5HetBLjY4TN",
        "lat": lat.toString(),
        "lon": lon.toString(),
        "asl": "279",
        "format": "json",
      },
    );
    print(uri);
    final moonResponse = await http.get(uri);
    print('Received Weather API response');

    if (expansiveResponse.statusCode != 200) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    if (moonResponse.statusCode != 200) {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return APIData.fromJson(
        jsonDecode(expansiveResponse.body) as Map<String, dynamic>,
        jsonDecode(moonResponse.body) as Map<String, dynamic>,
      );
    }
  }
}

typedef DailyHourly<T> = List<List<T>>;

class HourlyData {
  final DailyHourly time;
  final DailyHourly uvindex; //
  final DailyHourly fog_probability; //
  final DailyHourly snowfraction;
  final DailyHourly windspeed; //
  final DailyHourly temperature; //
  final DailyHourly sunshinetime; //
  final DailyHourly precipitation_probability; //
  final DailyHourly convective_precipitation;
  final DailyHourly highclouds;
  final DailyHourly rainspot;
  final DailyHourly pictocode;
  final DailyHourly felttemperature; //
  final DailyHourly precipitation; //
  final DailyHourly lowclouds;
  final DailyHourly visibility; //
  final DailyHourly isdaylight;
  final DailyHourly midclouds;
  final DailyHourly totalcloudcover; //
  final DailyHourly relativehumidity;
  final DailyHourly sealevelpressure;
  final DailyHourly winddirection; //

  const HourlyData({
    required this.time,
    required this.uvindex,
    required this.fog_probability,
    required this.snowfraction,
    required this.windspeed,
    required this.temperature,
    required this.sunshinetime,
    required this.precipitation_probability,
    required this.convective_precipitation,
    required this.highclouds,
    required this.rainspot,
    required this.pictocode,
    required this.felttemperature,
    required this.precipitation,
    required this.lowclouds,
    required this.visibility,
    required this.isdaylight,
    required this.midclouds,
    required this.totalcloudcover,
    required this.relativehumidity,
    required this.sealevelpressure,
    required this.winddirection,
  });
}

class DailyData {
  final List time;
  final List temperature_instant;
  final List precipitation;
  final List predictability;
  final List temperature_max;
  final List sealevelpressure_mean;
  final List windspeed_mean;
  final List precipitation_hours;
  final List sealevelpressure_min;
  final List pictocode;
  final List snowfraction;
  final List humiditygreater90_hours;
  final List convective_precipitation;
  final List relativehumidity_max;
  final List temperature_min;
  final List winddirection;
  final List felttemperature_max;
  final List relativehumidity_min;
  final List felttemperature_mean;
  final List windspeed_min;
  final List felttemperature_min;
  final List precipitation_probability;
  final List uvindex;
  final List rainspot;
  final List temperature_mean;
  final List sealevelpressure_max;
  final List relativehumidity_mean;
  final List predictability_class;
  final List windspeed_max;
  final List moonrise;
  final List moonset;
  final List moonphasename;
  final List sunrise;
  final List sunset;

  const DailyData({
    required this.time,
    required this.temperature_instant,
    required this.precipitation,
    required this.predictability,
    required this.temperature_max,
    required this.sealevelpressure_mean,
    required this.windspeed_mean,
    required this.precipitation_hours,
    required this.sealevelpressure_min,
    required this.pictocode,
    required this.snowfraction,
    required this.humiditygreater90_hours,
    required this.convective_precipitation,
    required this.relativehumidity_max,
    required this.temperature_min,
    required this.winddirection,
    required this.felttemperature_max,
    required this.relativehumidity_min,
    required this.felttemperature_mean,
    required this.windspeed_min,
    required this.felttemperature_min,
    required this.precipitation_probability,
    required this.uvindex,
    required this.rainspot,
    required this.temperature_mean,
    required this.sealevelpressure_max,
    required this.relativehumidity_mean,
    required this.predictability_class,
    required this.windspeed_max,
    required this.moonrise,
    required this.moonset,
    required this.moonphasename,
    required this.sunrise,
    required this.sunset,
  });
}

class APIData {
  final Metadata metadata;
  final HourlyData hourlyData;
  final DailyData dailyData;

  const APIData({
    required this.metadata,
    required this.hourlyData,
    required this.dailyData,
  });

  factory APIData.fromJson(Map<String, dynamic> json, Map<String, dynamic> moonJson) {
    var hourly = json["data_1h"];
    var daily = json["data_day"];
    var moon = moonJson["data_day"];
    return APIData(
      metadata: Metadata.fromJson(json['metadata']),
      hourlyData: HourlyData(
        time: reshape(hourly['time']),
        uvindex: reshape(hourly['uvindex']),
        fog_probability: reshape(hourly['fog_probability']),
        snowfraction: reshape(hourly['snowfraction']),
        windspeed: reshape(hourly['windspeed']),
        temperature: reshape(hourly['temperature']),
        sunshinetime: reshape(hourly['sunshinetime']),
        precipitation_probability: reshape(hourly['precipitation_probability']),
        convective_precipitation: reshape(hourly['convective_precipitation']),
        highclouds: reshape(hourly['highclouds']),
        rainspot: reshape(hourly['rainspot']),
        pictocode: reshape(hourly['pictocode']),
        felttemperature: reshape(hourly['felttemperature']),
        precipitation: reshape(hourly['precipitation']),
        lowclouds: reshape(hourly['lowclouds']),
        visibility: reshape(hourly['visibility']),
        isdaylight: reshape(hourly['isdaylight']),
        midclouds: reshape(hourly['midclouds']),
        totalcloudcover: reshape(hourly['totalcloudcover']),
        relativehumidity: reshape(hourly['relativehumidity']),
        sealevelpressure: reshape(hourly['sealevelpressure']),
        winddirection: reshape(hourly['winddirection']),
      ),
      dailyData: DailyData(
        time: daily["time"],
        temperature_instant: daily["temperature_instant"],
        precipitation: daily["precipitation"],
        predictability: daily["predictability"],
        temperature_max: daily["temperature_max"],
        sealevelpressure_mean: daily["sealevelpressure_mean"],
        windspeed_mean: daily["windspeed_mean"],
        precipitation_hours: daily["precipitation_hours"],
        sealevelpressure_min: daily["sealevelpressure_min"],
        pictocode: daily["pictocode"],
        snowfraction: daily["snowfraction"],
        humiditygreater90_hours: daily["humiditygreater90_hours"],
        convective_precipitation: daily["convective_precipitation"],
        relativehumidity_max: daily["relativehumidity_max"],
        temperature_min: daily["temperature_min"],
        winddirection: daily["winddirection"],
        felttemperature_max: daily["felttemperature_max"],
        relativehumidity_min: daily["relativehumidity_min"],
        felttemperature_mean: daily["felttemperature_mean"],
        windspeed_min: daily["windspeed_min"],
        felttemperature_min: daily["felttemperature_min"],
        precipitation_probability: daily["precipitation_probability"],
        uvindex: daily["uvindex"],
        rainspot: daily["rainspot"],
        temperature_mean: daily["temperature_mean"],
        sealevelpressure_max: daily["sealevelpressure_max"],
        relativehumidity_mean: daily["relativehumidity_mean"],
        predictability_class: daily["predictability_class"],
        windspeed_max: daily["windspeed_max"],
        moonrise: moon["moonrise"],
        moonphasename: moon["moonphasename"],
        moonset: moon["moonset"],
        sunrise: moon["sunrise"],
        sunset: moon["sunset"],
      ),
    );
  }

  static DailyHourly reshape(List list) {
    DailyHourly ret = [];
    for (int i = 0; i < 7; i++) {
      List day = [];
      for (int j = 0; j < 24; j++) {
        day.add(list[i * 24 + j]);
      }
      ret.add(day);
    }
    return ret;
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
