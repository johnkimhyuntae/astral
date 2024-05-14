import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'log_entry.dart';

class LogPage extends StatelessWidget {
  const LogPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Your Logs'),
      ),
      body: Center(
        heightFactor: 500,
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: 1,
          mainAxisSpacing: 0.0,
          children: const <Widget>[
            LogEntry(title:"foo"),
            LogEntry(title:"bar"),
            LogEntry(title:"baz"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
