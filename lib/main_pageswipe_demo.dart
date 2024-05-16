import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'weather_info_card.dart';
import 'time_weather_info_card.dart';
import 'day_page.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'astral_state.dart';


const IconData collectionsBookmarkRounded =
IconData(0xf656, fontFamily: 'MaterialIcons');

void main() {
  runApp(const AstralApp());
}

class AstralApp extends StatelessWidget {
  const AstralApp({super.key});

  @override
  Widget build(BuildContext context) {
    const foreground = Color.fromRGBO(243, 229, 165, 1.0);
    const background = Color.fromRGBO(37, 40, 58, 1.0);
    return ChangeNotifierProvider(
      create: (context) => AstralState(),
      child: MaterialApp(
        title: 'Astral',
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme(
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
        home: const MyHomePage(title: 'Astral'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              itemCount: 7, //number of pages
              itemBuilder: (context, index) {
                return DayPage();
                },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: PageIndicator(
                tabController: _tabController,
                currentPageIndex: _currentPageIndex,
                onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                isOnDesktopAndWeb: _isOnDesktopAndWeb,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TopBar(),
            ),
            ],
          ),
      ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }
  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
  bool get _isOnDesktopAndWeb {
    return false;
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  }) : super(key: key);

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.surface,
            selectedColor: colorScheme.primary,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 6) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}