import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'astral_state.dart';

void main() {
  runApp(const AstralApp());
}

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  @override
  Widget build(BuildContext context) {
    const foreground = Color.fromRGBO(243, 229, 165, 1.0);
    const background = Color.fromRGBO(37, 40, 58, 1.0);
    return MaterialApp(
      title: 'Astral',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
            // TODO: Change each color to semantically correct thing
            brightness: Brightness.dark,
            primary: Colors.black,
            onPrimary: foreground,
            secondary: Colors.black,
            onSecondary: foreground,
            error: Colors.black,
            onError: foreground,
            background: background,
            onBackground: Colors.white,
            surface: foreground,
            onSurface: Colors.black),
      ),
      themeMode: ThemeMode.dark,
      home: ChangeNotifierProvider(
        create: (context) => AstralState(),
        child: const HomePage(),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}