import 'package:flutter/material.dart';

import 'weather_info_card.dart';
import 'day_page.dart';
import 'home_page.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class WeatherInfoExpandedPage extends StatelessWidget {
  const WeatherInfoExpandedPage(
      {super.key, required this.activated});

  final Widget activated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              children: [
                TopBar(),
                Flexible(child: DayPage(original: false,)),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),
            Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: activated,
            ),
          ],
        ),
      ),
    );
  }
}
