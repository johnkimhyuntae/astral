import 'package:astral/weather_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'day_page.dart';
import 'home_page.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class WeatherInfoExpanded extends StatelessWidget {
  const WeatherInfoExpanded(
      {super.key, required this.activated});

  final Widget activated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const TopBar(),
                Flexible(child: DayPage(date: DateTime.now())),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        backgroundColor: topBg,
                        shape: const CircleBorder()),
                    child: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(IconData(0xe093,
                            fontFamily: 'MaterialIcons',
                            matchTextDirection: true)))),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: activated,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
