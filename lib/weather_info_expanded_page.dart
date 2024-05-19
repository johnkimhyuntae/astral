import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';
import 'main_page.dart';
import 'page_swiper.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class WeatherInfoExpandedPage extends StatelessWidget {
  const WeatherInfoExpandedPage({super.key, required this.activated});

  final Widget activated;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const TopBar(),
                Flexible(
                  child: PageSwiper(
                    original: false,
                    initialPageIndex: appState.currentDayIndex,
                  ),
                ),
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
