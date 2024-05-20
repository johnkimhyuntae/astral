import 'weather_info_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';

class TimeWeatherInfoCard extends StatelessWidget {
  final WType wType;

  const TimeWeatherInfoCard(this.wType, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(82, 85, 102, 1.0).withOpacity(0.4),
      elevation: 8.0,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.2,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          children: [
            for (var i = 0; i < 24; i++)
              TimeCard(
                wType: wType,
                hour: i,
              ),
          ],
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  TimeCard({super.key, required this.wType, required this.hour}) {}

  final WType wType;
  final int hour;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    switch (wType) {
      case WType.temperature:
        String rainVal = appState.statIdValueMapHourly[WType.precipitationPercentage]![appState.currentDayIndex][hour];
        String tempVal = appState.statIdValueMapHourly[WType.temperature]![appState.currentDayIndex][hour];
        String cloudVal = appState.statIdValueMapHourly[WType.cloudPercentage]![appState.currentDayIndex][hour];
        int snowVal = appState.apiData?.hourlyData.snowfraction[appState.currentDayIndex][hour]??0;
    return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Card(
            // color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    Text("${hour}:00"),
                    snowVal == 1 ? Icon(Icons.cloudy_snowing, color: Colors.black) :
                    int.parse(('0' + rainVal).substring(0, rainVal.length)) < 10 ? Icon(Icons.wb_sunny_outlined, color: Colors.black) : Icon(Icons.water_drop_outlined, color: Colors.black),
                    Text(tempVal),
                ],
              ),
            ),
          ),
        );

      case WType.windSpeed:
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Card(
            // color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("$hour:00"),
                ],
              ),
            ),
          ),
        );

      default:
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            // color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("$hour:00"),
                ],
              ),
            ),
          ),
        );
    }


    }
  }

