import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'log_page_body.dart';

const Color topBg = Color.fromRGBO(253, 245, 230, 1.0);

class LogPage extends StatelessWidget {
  const LogPage({super.key});

  void changeLocation(String s) {}

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopBar(),
            Flexible(child: LogPageBody()),
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: topBg,
                    shape: const CircleBorder()),
                child: const Padding(padding: const EdgeInsets.only(left: 10), child: Icon(IconData(0xe093, fontFamily: 'MaterialIcons', matchTextDirection: true)))),
            const Expanded(
              child:
                Center(
                  child: Text(
                    "Your Logs",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ), 
            ),   
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: topBg,
                shape: const CircleBorder(),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
