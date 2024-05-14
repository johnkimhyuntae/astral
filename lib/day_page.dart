import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'weather_info_card.dart';

class DayPage extends StatelessWidget {
  const DayPage({
    super.key,
    required this.date,
  });

  final DateTime date;

  String dateString(){
    return DateFormat("EEEE, d MMMM y").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(
            "assets/images/moon.png",
            width: 300,
          ),
        ),
        Text(
          dateString(),
          style: const TextStyle(color: Colors.white),
        ),
        Flexible(
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: const <Widget>[
              WeatherInfoCard(title: "Wind Speed"),
              WeatherInfoCard(title: "bar"),
              WeatherInfoCard(title: "baz"),
              WeatherInfoCard(title: "foo"),
              WeatherInfoCard(title: "bar"),
              WeatherInfoCard(title: "baz"),
              WeatherInfoCard(title: "foo"),
              WeatherInfoCard(title: "bar"),
              WeatherInfoCard(title: "baz"),
            ],
          ),
        ),
      ],
    );
  }
}
