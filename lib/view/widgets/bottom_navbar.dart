import 'package:spendly_ui/view/pages/home/navbar_item.dart';
import 'package:flutter/material.dart';

class SpendlyBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;
  final List<NavigationBarItemProvidable> screens;
  final ValueChanged<int> onTap;

  const SpendlyBottomNavigationBar(
      {super.key,
      required this.currentIndex,
      required this.screens,
      required this.pageController,
      required this.onTap});

  @override
  State<SpendlyBottomNavigationBar> createState() =>
      _SpendlyBottomNavigationBarState();
}

class _SpendlyBottomNavigationBarState
    extends State<SpendlyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: widget.screens
          .map((screen) => screen.getNavigationBarItem())
          .toList(),
    );
  }
}
