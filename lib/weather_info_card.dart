import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'weather_info_expanded_page.dart';
import 'time_weather_info_card.dart';
import 'astral_state.dart';
import 'weather_info_type.dart';

class WeatherInfoCard extends StatelessWidget {
  final WType wType;

  const WeatherInfoCard(this.wType, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                return WeatherInfoExpandedPage(
                  activated: WeatherInfoCardExpanded(
                    title: appState.statIdTitleMap[wType]!,
                    value: appState.statIdValueMapHourly[wType]![
                        appState.currentDayIndex][DateTime.now().hour], //[DAY][HOUR]
                  ),
                );
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Card(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        appState.statIdTitleMap[wType]!.toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    appState.statIdValueMapDailyAverage[wType]![
                        appState.currentDayIndex],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 32,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Positioned(
                right: 0,
                child: Icon(
                  Icons.drag_indicator_outlined,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInfoCardExpanded extends StatelessWidget {
  final String title;
  final String value;

  const WeatherInfoCardExpanded({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const TimeWeatherInfoCard(),
                    Center(
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Daily Summary',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Wind is currently $value from the NE. Today, wind speeds are $value to $value km/h, with gusts up to $value km/h.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Daily Comparison',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The peak wind speed today is lower than yesterday.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'About $title',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'The wind speed is calculated using the average over a short period of time. Gusts are short bursts of wind above this average. A gust typically lasts under 20 seconds.',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                iconSize: 35,
                color: Colors.red,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
