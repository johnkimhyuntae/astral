import 'package:astral/log_entry_expanded.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);


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
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => LogEntryExpanded(
                    title: widget.title,
                    date: widget.date,
                ),
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
                        onPressed: () {},
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
                          child: Image.asset(
                            "assets/images/moon.png",
                            color: Colors.black.withOpacity(0.75),
                            colorBlendMode: BlendMode.dstIn,
                          ),
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
