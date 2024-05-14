import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
      body: Column(
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
            child: GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: const <Widget>[
                WeatherInfoCard(title: "Wind Speed"),
                WeatherInfoCard(title: "bar"),
                WeatherInfoCard(title: "baz"),
                WeatherInfoCard(title: "foo"),
                WeatherInfoCard(title: "bar"),
                WeatherInfoCard(title: "baz"),
                WeatherInfoCard(title: "foo"),
                WeatherInfoCard(title: "bar"),
                WeatherInfoCard(title: "baz"),
              ],
            ),
          ),
        ],
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
