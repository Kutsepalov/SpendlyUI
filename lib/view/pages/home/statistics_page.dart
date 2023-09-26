import '../../pages/home/navbar_item.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const StatisticsPage({super.key});

  @override
  State<StatefulWidget> createState() => _StatisticsPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart),
      label: 'Statistics',
      backgroundColor: Colors.green,
    );
  }
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Statistics', style: TextStyle(fontSize: 60))),
    );
  }
}
