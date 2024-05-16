import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class LogEntryExpanded extends StatefulWidget {
  final String title;
  final DateTime date;
  const LogEntryExpanded({super.key, required this.title, required this.date});
  
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
        height: height - 20,
        width: width - 20,
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                          width: 2 * width / 3,
                          child: Text(widget.title,
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary
                            ),
                          ),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 16.0),
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
                      padding: const EdgeInsets.only(top: 16.0, bottom: 10.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 100,
                          width: 150,
                          child: Image.asset(
                            "assets/images/moon.png",
                            color: Colors.black.withOpacity(0.75),
                            colorBlendMode: BlendMode.dstIn,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 16.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: (85/100) * width,
                          child: Text("blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah ",
                            style: TextStyle(
                                fontSize: 16,
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