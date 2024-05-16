import 'package:astral/log_page.dart';
import 'package:astral/weather_info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'log_entry.dart';
import 'log_page_body.dart';
import 'log_page.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class LogEntryExpandedPage extends StatelessWidget {
  const LogEntryExpandedPage(
      {super.key, required this.activated});

  final Widget activated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Column(
              children: [
                Flexible(child: LogPage()),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.7),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: activated,
            ),
          ],
        ),
      ),
    );
  }
}
