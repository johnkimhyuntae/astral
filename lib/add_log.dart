import 'package:astral/log_entry_expanded.dart';
import 'package:astral/log_entry_expanded_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class AddLog extends StatefulWidget {
  final DateTime date;
  const AddLog({super.key, required this.date});
  
  @override
  State<AddLog> createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String userTitle = '';
    String userDescription = '';

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
                          child: TextField(
                            onChanged: (value) {
                              // This function is called whenever the user types in the text field
                              setState(() {
                                userTitle = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                            ),
                          )
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
                          child: TextField(
                            onChanged: (value) {
                              // This function is called whenever the user types in the text field
                              setState(() {
                                userDescription = value;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                          )
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