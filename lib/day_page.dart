import 'package:astral/weather_info_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:reorderable_staggered_scroll_view/reorderable_staggered_scroll_view.dart';

import 'astral_state.dart';

class DayPage extends StatelessWidget {
  const DayPage({
    super.key,
    required this.original,
    required this.dayIndex,
  });

  final bool original;
  final int dayIndex;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    DateTime latestUpdatedTime =
        appState.latestUpdatedTime.add(Duration(days: dayIndex));

    return ListView(
      controller: getScrollController(context),
      children: [
        moonAndTemperature(appState),
        Center(
          child: Text(
            dateString(latestUpdatedTime),
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
          child: /*This is a very necessary container for desktop*/ Container(
              child: ReorderableStaggeredScrollView.grid(
            crossAxisCount: 2,
            // TODO: Copy package into repo and make delay changeable
            children: appState.weatherInfoWidgetsList,
          )),
        ),
      ],
    );
  }

  Widget moonAndTemperature(AstralState appState) {
    return Padding(
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
            Text(
              appState.statIdValueMapHourly[WType.temperature]![
                  appState.currentDayIndex][DateTime.now().hour],
              style: const TextStyle(
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
    );
  }

  String dateString(DateTime dateTime) {
    return DateFormat("EEEE, d MMMM y").format(dateTime);
  }

  ScrollController getScrollController(BuildContext context) {
    var appState = context.watch<AstralState>();
    ScrollController c;
    if (original) {
      c = appState.scrollController;
    } else {
      double sPos = appState.scrollController.offset;
      c = ScrollController(initialScrollOffset: sPos);
    }
    return c;
  }
}
