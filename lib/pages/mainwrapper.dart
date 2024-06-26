import 'package:ebook_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _goBranch(index);
        },
        items: [
          SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text("Home"), selectedColor: firstColor),
          SalomonBottomBarItem(icon: const Icon(Icons.favorite), title: const Text("Favorite"), selectedColor: firstColor)
        ],
      ),
    );
  }
}