// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'weather_info_card.dart';
//
// const IconData collectionsBookmarkRounded =
// IconData(0xf656, fontFamily: 'MaterialIcons');
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Astral',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Astral'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage>
//     with TickerProviderStateMixin {
//   late PageController _pageViewController;
//   late TabController _tabController;
//   int _currentPageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _pageViewController = PageController();
//     _tabController = TabController(length: 7, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _pageViewController.dispose();
//     _tabController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:
//         Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageViewController,
//             onPageChanged: _handlePageViewChanged,
//             children: [
//               Scaffold(
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page2
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page3
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page4
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page5
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page6
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//               Scaffold( //page7
//                 body: Column(
//                   children: [
//                     Image.asset("assets/images/moon.png", width: 300,),
//                     const Text("Friday, 23rd May 2024"),
//                     Flexible(
//                       child: GridView.count(
//                         padding: const EdgeInsets.all(20),
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10,
//                         children: const <Widget>[
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                           WeatherInfoCard(title:"foo"),
//                           WeatherInfoCard(title:"bar"),
//                           WeatherInfoCard(title:"baz"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 floatingActionButton: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LogPage(),
//                       ),
//                     );
//                   },
//                   child: const Icon(collectionsBookmarkRounded),
//                 ),
//               ),
//             ],
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: PageIndicator(
//               tabController: _tabController,
//               currentPageIndex: _currentPageIndex,
//               onUpdateCurrentPageIndex: _updateCurrentPageIndex,
//               isOnDesktopAndWeb: _isOnDesktopAndWeb,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _handlePageViewChanged(int currentPageIndex) {
//     setState(() {
//       _currentPageIndex = currentPageIndex;
//     });
//   }
//
//   void _updateCurrentPageIndex(int index) {
//     _tabController.index = index;
//     _pageViewController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }
//
//   bool get _isOnDesktopAndWeb {
//     return false; // Update this based on your platform detection logic
//   }
// }
//
// class PageIndicator extends StatelessWidget {
//   const PageIndicator({
//     Key? key,
//     required this.tabController,
//     required this.currentPageIndex,
//     required this.onUpdateCurrentPageIndex,
//     required this.isOnDesktopAndWeb,
//   }) : super(key: key);
//
//   final int currentPageIndex;
//   final TabController tabController;
//   final void Function(int) onUpdateCurrentPageIndex;
//   final bool isOnDesktopAndWeb;
//
//   @override
//   Widget build(BuildContext context) {
//     if (!isOnDesktopAndWeb) {
//       return const SizedBox.shrink();
//     }
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           IconButton(
//             splashRadius: 16.0,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               if (currentPageIndex == 0) {
//                 return;
//               }
//               onUpdateCurrentPageIndex(currentPageIndex - 1);
//             },
//             icon: const Icon(
//               Icons.arrow_left_rounded,
//               size: 32.0,
//             ),
//           ),
//           TabPageSelector(
//             controller: tabController,
//             color: colorScheme.surface,
//             selectedColor: colorScheme.primary,
//           ),
//           IconButton(
//             splashRadius: 16.0,
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               if (currentPageIndex == 2) {
//                 return;
//               }
//               onUpdateCurrentPageIndex(currentPageIndex + 1);
//             },
//             icon: const Icon(
//               Icons.arrow_right_rounded,
//               size: 32.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class LogPage extends StatelessWidget {
//   const LogPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
//
// lalala
