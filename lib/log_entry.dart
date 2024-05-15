import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class LogEntry extends StatefulWidget {
  final String title;
  final DateTime date;
  const LogEntry({super.key, required this.title, required this.date});
  
  @override
  State<LogEntry> createState() => _LogEntryState();
}

class _LogEntryState extends State<LogEntry> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Card(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.title,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                ),
              ),
              Spacer(flex: 20),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(DateFormat("EEEE, d MMMM y").format(widget.date),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
