import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogEntry extends StatefulWidget {
  final String title;
  const LogEntry({super.key, required this.title});
  
  @override
  State<LogEntry> createState() => _LogEntryState();
}

class _LogEntryState extends State<LogEntry> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 160,
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.title),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text('20km/h',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
