import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 130,
                  child: Image.asset(
                    "assets/images/moon.png",
                    color: Colors.black.withOpacity(0.75),
                    colorBlendMode: BlendMode.dstIn,
                  ),
                ),
                const Text(
                  "14°C",
                  style: TextStyle(
                    color: Color.fromRGBO(253, 245, 230, 1.0),
                    fontSize: 36,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Colors.black,
                      ),
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Colors.black,
                      ),
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Text(
            dateString(),
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
          child: StaggeredGrid.count(
            // Staggered grid view, customise size of each tile
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            children: const <Widget>[
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: WeatherInfoCard(title: "WIND SPEED", value: "20 km/h"),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: WeatherInfoCard(title: "VISIBILITY", value: "5 km"),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 1,
                child: WeatherInfoCard(title: "baz", value: "qux"),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: WeatherInfoCard(title: "bar", value: "baz"),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: WeatherInfoCard(title: "bar", value: "baz"),
              ),
              StaggeredGridTile.count(
                crossAxisCellCount: 2,
                mainAxisCellCount: 2,
                child: WeatherInfoCard(title: "foo", value: "bar"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// SingleChildScrollView( // Makes home page scrollable
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Image.asset(
//                 "assets/images/moon.png",
//                 width: 300,
//               ),
//             ),
//             const Text(
//               "Thursday, 23rd May 2024",
//               style: TextStyle(color: Colors.white),
//             ),
//             Flexible(
//               fit: FlexFit.loose,
//               child:
//             ),
//           ],
//         ),
