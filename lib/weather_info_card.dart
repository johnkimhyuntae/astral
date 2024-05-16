import 'package:astral/weather_info_expanded_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';

class WeatherInfoCard extends StatelessWidget {
  final String statId;

  const WeatherInfoCard(this.statId, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) {
              return WeatherInfoExpandedPage(
              activated: WeatherInfoCardExpanded(
                title: appState.statIdTitleMap[statId]!,
                value: appState.statIdValueMap[statId]!,
                ),
              );
            },
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  appState.statIdTitleMap[statId]!,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              appState.statIdValueMap[statId]!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 40,
              ),
            ),
          ],
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                    ),
                  ),
                ],
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
