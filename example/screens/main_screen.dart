import 'package:flutter/material.dart';

import 'package:ezkit/ezkit.dart';

class MainScreen extends StatelessWidget {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false, // behind the status bar
        child: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text('Tab 1'),
            Text('Tab 2'),
            Text('Tab 3'),
            Text('Tab 4'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        key: Navigation.bottomNav,
        controller: this._controller,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Tab 2'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Tab 3'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            title: Text('Tab 4'),
          ),
        ],
      ),
    );
  }
}
