import 'package:astral/log_entry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'astral_state.dart';
import 'log_data.dart';


class LogPageBody extends StatelessWidget {
  const LogPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    List<LogEntry> entries = [];
    for (LogData entry in appState.logs) {
      entries.add(LogEntry(id: entry.id, title: entry.title, date: entry.date, log: entry.log));
    };
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top:10, left: 20, right: 20),
          child: Column(
            children: entries,
          ),
        ),
      ],
    );
  }
}
