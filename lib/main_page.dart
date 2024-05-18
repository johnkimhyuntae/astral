import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';
import 'page_swiper.dart';
import 'log_page.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            Flexible(
              child: PageSwiper(
                original: true,
                initialPageIndex: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: topBg,
                    shape: const CircleBorder()),
                child: const Icon(Icons.format_list_bulleted, size: 25)),
            const LocationField(),
            ElevatedButton(
              onPressed: () {
                Provider.of<AstralState>(context, listen: false)
                    .updateWeather();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: topBg,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.edit,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationField extends StatelessWidget {
  const LocationField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return Expanded(
      child: TextFormField(
        initialValue: "Cambridge, UK",
        onFieldSubmitted: appState.updateLocation,
        textInputAction: TextInputAction.search,
        style: const TextStyle(),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: topBg,
          hintText: "Location",
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              style: BorderStyle.none,
            ),
          ),
          suffixIcon: const Icon(Icons.search, size: 25),
        ),
      ),
    );
  }
}
