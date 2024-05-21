import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';
import 'main_page.dart';
import 'astral_state.dart';

void main() {
  runApp(const AstralApp());
}

class MouseTouchScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

final navigatorKey = GlobalKey<NavigatorState>();

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  @override
  Widget build(BuildContext context) {
    // const foreground = Color.fromRGBO(243, 229, 165, 1.0); //old yellowier widget colour
    const foreground = Color.fromRGBO(246, 231, 196, 1.0);
    const background = Color.fromRGBO(36, 38, 56, 1.0);
    const astralAccent = Color.fromRGBO(79, 52, 85, 1.0);
    const basicallyBlack = Color.fromRGBO(
        23, 25, 33, 1.0); //black but a bit bluer, to fit with navy
    const ohNoRed = Color.fromRGBO(187, 21, 18, 1.0);

    return ChangeNotifierProvider(
      create: (context) => AstralState(),
      child: MaterialApp(
        navigatorKey: navigatorKey, // Setting a global key for navigator
        title: 'Astral',
        scrollBehavior: MouseTouchScrollBehavior(),
        theme: ThemeData(
          fontFamily: 'Nunito',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'Nunito'),
            displayMedium: TextStyle(fontFamily: 'Nunito'),
            displaySmall: TextStyle(fontFamily: 'Nunito'),
            headlineLarge: TextStyle(fontFamily: 'Nunito'),
            headlineMedium: TextStyle(fontFamily: 'Nunito'),
            headlineSmall: TextStyle(fontFamily: 'Nunito'),
            titleLarge: TextStyle(fontFamily: 'Nunito'),
            titleMedium: TextStyle(fontFamily: 'Nunito'),
            titleSmall: TextStyle(fontFamily: 'Nunito'),
            bodyLarge: TextStyle(fontFamily: 'Nunito'),
            bodyMedium: TextStyle(fontFamily: 'Nunito'),
            bodySmall: TextStyle(fontFamily: 'Nunito'),
            labelLarge: TextStyle(fontFamily: 'Nunito'),
            labelMedium: TextStyle(fontFamily: 'Nunito'),
            labelSmall: TextStyle(fontFamily: 'Nunito'),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'Nunito'),
            displayMedium: TextStyle(fontFamily: 'Nunito'),
            displaySmall: TextStyle(fontFamily: 'Nunito'),
            headlineLarge: TextStyle(fontFamily: 'Nunito'),
            headlineMedium: TextStyle(fontFamily: 'Nunito'),
            headlineSmall: TextStyle(fontFamily: 'Nunito'),
            titleLarge: TextStyle(fontFamily: 'Nunito'),
            titleMedium: TextStyle(fontFamily: 'Nunito'),
            titleSmall: TextStyle(fontFamily: 'Nunito'),
            bodyLarge: TextStyle(fontFamily: 'Nunito'),
            bodyMedium: TextStyle(fontFamily: 'Nunito'),
            bodySmall: TextStyle(fontFamily: 'Nunito'),
            labelLarge: TextStyle(fontFamily: 'Nunito'),
            labelMedium: TextStyle(fontFamily: 'Nunito'),
            labelSmall: TextStyle(fontFamily: 'Nunito'),
          ),
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
