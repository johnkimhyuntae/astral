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

  String dateString() {
    return DateFormat("EEEE, d MMMM y").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            height: 130,
            child: Image.asset(
              "assets/images/moon.png",
            ),
          ),
        ),
        Center(
          child: Text(
            dateString(),
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
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
      ],
    );
  }
}
