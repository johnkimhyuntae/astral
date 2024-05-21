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
                    wType: wType,
                  ),
                );
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
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
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: MediaQuery.of(context).size.width / 30,
                              ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 4,
                    ),
            
                    // Value of the weather info card
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Text(
                          appState.statIdValueMapDailyAverage[wType]![
                              appState.currentDayIndex],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: constraints.maxWidth / 5,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                  ],
                ),
                const Positioned(
                  right: 1,
                  top: 4,
                  child: Icon(
                    Icons.drag_indicator_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherInfoCardExpanded extends StatelessWidget {
  final String title;
  final String value;
  final WType wType;

  const WeatherInfoCardExpanded({
    super.key,
    required this.title,
    required this.value,
    required this.wType,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    final bool hasHourlyData = !appState.statIdValueMapHourly[wType]![0].contains("⟳");

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

                    // Title of the expanded weather info card
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

                    if (hasHourlyData) const SizedBox(height: 30),

                    if (hasHourlyData) SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: TimeWeatherInfoCard(wType)
                    ),

                    const SizedBox(height: 30),

                    // About [weather metric]
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
                        appState.statIdAboutMap[wType]!,
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
