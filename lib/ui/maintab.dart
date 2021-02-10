import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mmtweet/ui/pages/home.dart';
import 'package:mmtweet/ui/pages/profile.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  ProfilePage(),
];

class MainTab extends StatefulWidget {
  static const routeName = '/maintab';
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  int _currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Theme.of(context).accentColor,
        strokeColor: Color.fromARGB(50, 240, 108, 155),
        unSelectedColor: Colors.grey[600],
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(icon: Icons.home),
          CustomNavigationBarItem(icon: Icons.people),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

// class MainTab extends StatefulWidget {
//   MainTab() : super();
//   static const routeName = '/maintab';

//   final String title = "Bottom Navigation Demo";

//   @override
//   MainTabState createState() => MainTabState();
// }

// class MainTabState extends State<MainTab> with SingleTickerProviderStateMixin {
//   //

//   TabController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = TabController(length: 3, vsync: this);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bottom Navigation Demo"),
//       ),
//       body: TabBarView(
//         children: <Widget>[
//           HomePage(),
//           ExchangePage(),
//           ProfilePage(),
//         ],
//         controller: controller,
//       ),
//       bottomNavigationBar: Material(
//         color: Colors.blue,
//         child: TabBar(
//           tabs: <Widget>[
//             Tab(
//               icon: Icon(Icons.favorite),
//             ),
//             Tab(
//               icon: Icon(Icons.add),
//             ),
//             Tab(
//               icon: Icon(Icons.airport_shuttle),
//             ),
//           ],
//           controller: controller,
//         ),
//       ),
//     );
//   }
// }
