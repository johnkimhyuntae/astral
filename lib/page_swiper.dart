import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'astral_state.dart';
import 'day_page.dart';

class PageSwiper extends StatefulWidget {
  const PageSwiper(
      {super.key, required this.original, required this.initialPageIndex});

  final bool original;
  final int initialPageIndex;

  @override
  State<PageSwiper> createState() => _PageSwiperState();
}

class _PageSwiperState extends State<PageSwiper> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: widget.initialPageIndex);
    _tabController = TabController(
      initialIndex: widget.initialPageIndex,
      length: 7,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AstralState>();
    return Stack(
        children: [
          PageView.builder(
            controller: _pageViewController,
            onPageChanged: appState.updatePageIndex,
            itemCount: 7, //number of pages
            itemBuilder: (context, index) {
              return DayPage(
                original: widget.original,
                dayIndex: index,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PageIndicator(
              tabController: _tabController,
              onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            ),
          ),
        ],
      );
  }

  void _updateCurrentPageIndex(int index) {
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.onUpdateCurrentPageIndex,
  });

  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  bool get isOnDesktopAndWeb {
    // FIXME
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (isOnDesktopAndWeb) {
      // FIXME
      return const SizedBox.shrink();
    }

    var appState = context.watch<AstralState>();
    int currentPageIndex = appState.currentPageIndex;
    tabController.index = currentPageIndex;
    // print(tabController.index);
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(30, 32, 47, 0.8), //slightly darker navy for bar
        // borderRadius: BorderRadius.circular(20.0), //rounded corners on bar
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(37, 40, 58, 0.6), //background colour shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), //shadow position
          ),
        ],
      ),
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
