import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherInfoCard extends StatefulWidget {
  final String title;
  const WeatherInfoCard({super.key, required this.title});

  @override
  State<WeatherInfoCard> createState() => _WeatherInfoCardState();
}

class _WeatherInfoCardState extends State<WeatherInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text('20km/h',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 40,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
