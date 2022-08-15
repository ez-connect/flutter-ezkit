import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final PageController controller;
  final List<BottomNavigationBarItem> items;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  BottomNavigation({
    Key? key,
    required this.controller,
    this.items = const [],
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  }) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: this.widget.items,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: this.widget.showSelectedLabels,
      showUnselectedLabels: this.widget.showUnselectedLabels,
      currentIndex: this._index,
      onTap: (page) => this.jumpToPage(page),
    );
  }

  void jumpToPage(int page) {
    this.setState(() {
      this._index = page;
    });

    this.widget.controller.jumpToPage(page);
  }
}
