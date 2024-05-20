import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class LogEntryExpanded extends StatefulWidget {
  final String title;
  final DateTime date;
  final String log;
  final File? image;
  const LogEntryExpanded({super.key, required this.title, required this.date, required this.log, required this.image});
  
  @override
  State<LogEntryExpanded> createState() => _LogEntryExpandedState();
}

class _LogEntryExpandedState extends State<LogEntryExpanded> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        // height: height - 20,
        width: width - 20,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          // height: (1/12) * height,
                          width: 1.8 * width / 3,
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 5.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat("EEEE, d MMMM y").format(widget.date),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          // height: (1/8) * height,
                          width: (80/100) * width,
                          child: (widget.image != null) ? ((kIsWeb) ? Image.network(widget.image!.path) : Image.file(widget.image!)) : const Text(" ")
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          // height: (3/6) * height,
                          width: (75/100) * width,
                          child: Text(
                            widget.log,
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0, top: 5.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                        iconSize: 35,
                        color: Colors.red,
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        )
                      ),
                    ),
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