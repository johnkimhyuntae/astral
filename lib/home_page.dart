import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'day_page.dart';
import 'log_page.dart';

const IconData collectionsBookmarkRounded =
    IconData(0xf656, fontFamily: 'MaterialIcons');

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Astral"),
      ),
      body: DayPage(date: DateTime.now()),
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
