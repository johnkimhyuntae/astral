import 'package:astral/log_entry_expanded.dart';
import 'package:astral/log_entry_expanded_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'astral_state.dart';
import 'log_data.dart';
import 'package:uuid/uuid.dart';
import 'log_page.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class AddLog extends StatefulWidget {
  const AddLog({super.key});
  
  @override
  State<AddLog> createState() => _AddLogState();
}

class _AddLogState extends State<AddLog> {

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String userTitle = '';
    String userLog = '';
    var uuid = Uuid();
    DateTime date = DateTime.now();

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
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                              ),
                            onChanged: (value) {
                              // This function is called whenever the user types in the text field
                              setState(() {userTitle = value;});
                              print(userTitle);
                            },
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, bottom: 16.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(DateFormat("EEEE, d MMMM y").format(date),
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
                            maxLines: 10,
                            onChanged: (uInput) {
                              // This function is called whenever the user types in the text field
                              setState(() {
                                userLog = uInput;
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
                      padding: const EdgeInsets.only(right: 7.0, top: 20.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                        iconSize: 35,
                        color: Colors.red,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          print(userTitle);
                          LogData x = LogData(id: uuid.v4(), title: userTitle, date: date, log: userLog, pathToImage: "assets/images/moon.png");
                          appState.logs.add(x);
                          print(appState.logs);

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