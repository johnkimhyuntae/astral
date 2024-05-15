import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'weather_info_card.dart';
import 'log_page.dart';

const IconData collectionsBookmarkRounded =
    IconData(0xf656, fontFamily: 'MaterialIcons');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const foreground = Color.fromRGBO(243, 229, 165, 1.0);
    return MaterialApp(
      title: 'Astral',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
            // TODO: Change each color to semantically correct thing
            brightness: Brightness.dark,
            primary: Colors.black,
            onPrimary: foreground,
            secondary: Colors.black,
            onSecondary: foreground,
            error: Colors.black,
            onError: foreground,
            background: Color.fromRGBO(37, 40, 58, 1.0),
            onBackground: Colors.white,
            surface: foreground,
            onSurface: Colors.black),
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Astral'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView( // Makes home page scrollable
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/images/moon.png",
                width: 300,
              ),
            ),
            const Text(
              "Thursday, 23rd May 2024",
              style: TextStyle(color: Colors.white),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6),
                child: StaggeredGrid.count( // Staggered grid view, customise size of each tile
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
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
                      child: WeatherInfoCard(title: "foo", value: "bar"),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: WeatherInfoCard(title: "bar", value: "baz"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LogPage()),
          );
        },
        child: const Icon(collectionsBookmarkRounded),
      ),
    );
  }
}
