import 'weather_info_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';

class TimeWeatherInfoCard extends StatelessWidget {
  const TimeWeatherInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        color: const Color.fromRGBO(82, 85, 102, 1.0).withOpacity(0.4),
        elevation: 8.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          children: [
            for (var i = 0; i < 24; i++)
              TimeCard(time: DateTime.now().add(Duration(hours: -DateTime.now().hour + i)),
                  rainVal: appState.statIdValueMapHourly[WType.precipitation]![appState.currentDayIndex][i],
                  tempVal: appState.statIdValueMapHourly[WType.temperature]![appState.currentDayIndex][i],
                  cloudVal: appState.statIdValueMapHourly[WType.cloudPercentage]![appState.currentDayIndex][i]),
          ],
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  TimeCard({super.key, required this.time, required this.rainVal, required this.tempVal, required this.cloudVal}) {}

  final DateTime time;
  final String rainVal;
  final String tempVal;
  final String cloudVal;

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${time.hour}:00"),
            (int.parse(rainVal) < 10) ? (Icon(Icons.sunny)) : (Icon(Icons.water_drop)),
            const Icon(Icons.water_drop),
            Text("$tempVal°C"),
          ],
        ),
      ),
    );
  }

}