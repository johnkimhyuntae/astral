import 'package:astral/log_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class LogPageBody extends StatelessWidget {
  const LogPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              LogEntry(title: "A crazy night in Cambridge!", date: DateTime.now()),
              LogEntry(title: "Birmingham Aurora???", date: DateTime.now()),
              LogEntry(title: "HOLY SHIT", date: DateTime.now()),
              LogEntry(title: "Night out with the loml", date: DateTime.now()),
              LogEntry(title: "I'm so tired...", date: DateTime.now()),
              LogEntry(title: "I hate logs now.", date: DateTime.now()),
            ],
          ),
        ),
      ],
    );
  }
}
