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
          padding: const EdgeInsets.only(top:10, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              LogEntry(title: "A crazy night in Cambridge! I can't believe I saw the northen lights in the UK???!!!", 
              date: DateTime.now(), log: "blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah "),
            ],
          ),
        ),
      ],
    );
  }
}
