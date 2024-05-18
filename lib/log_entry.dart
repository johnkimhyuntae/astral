import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:astral/log_data.dart';
import 'package:astral/log_entry_expanded.dart';
import 'package:astral/log_entry_expanded_page.dart';
import 'package:astral/log_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'astral_state.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);


class LogEntry extends StatefulWidget {
  final String id;
  final String title;
  final DateTime date;
  final String log;
  final File? image;
  const LogEntry({super.key, required this.id, required this.title, required this.date, required this.log, required this.image});
  
  @override
  State<LogEntry> createState() => _LogEntryState();
}

class _LogEntryState extends State<LogEntry> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return Center(
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => LogEntryExpandedPage(
                  activated: LogEntryExpanded(title: widget.title, date: widget.date, log: widget.log, image: widget.image)),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },
          child: Card(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          height: 100,
                          width: 200,
                          child: Text(widget.title,
                            style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat("EEEE, d MMMM y").format(widget.date),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 6.0, top: 4.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                        iconSize: 20,
                        color: Colors.red,
                        icon: const Icon(IconData(0xefa9, fontFamily: 'MaterialIcons')),
                        onPressed: () {
                          for (LogData entry in appState.logs) {
                            if (entry.id == widget.id) {
                              appState.logs.remove(entry);
                            }
                          }; 
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => LogPage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, right: 12.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: (widget.image != null) ? ((kIsWeb) ? Image.network(widget.image!.path) : Image.file(widget.image!)) : const Text("No Image")
                        ),
                      ),
                    )
                  ]
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
