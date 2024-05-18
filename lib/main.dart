import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_page.dart';
import 'astral_state.dart';

void main() {
  runApp(const AstralApp());
}

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const foreground = Color.fromRGBO(243, 229, 165, 1.0); //old yellowier widget colour
    const foreground = Color.fromRGBO(246, 231, 196, 1.0);
    const background = Color.fromRGBO(36, 38, 56, 1.0);
    const astralAccent = Color.fromRGBO(79, 52, 85, 1.0);
    const basicallyBlack = Color.fromRGBO(23, 25, 33, 1.0); //black but a bit bluer, to fit with navy
    const ohNoRed = Color.fromRGBO(187, 21, 18, 1.0);

    return ChangeNotifierProvider(
      create: (context) => AstralState(),
      child: MaterialApp(
        title: 'Astral',
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: basicallyBlack,
              onPrimary: foreground,
              secondary: astralAccent,
              onSecondary: foreground,
              error: ohNoRed,
              onError: foreground,
              background: background,
              onBackground: foreground,
              surface: foreground,
              onSurface: basicallyBlack),
        ),
        themeMode: ThemeMode.dark,
        home: const MainPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
