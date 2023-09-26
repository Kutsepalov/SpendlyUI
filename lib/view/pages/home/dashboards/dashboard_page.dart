import 'package:spendly_ui/view/pages/home/dashboards/accounts_page.dart';
import 'package:spendly_ui/view/pages/home/dashboards/budgets_page.dart';

import '../navbar_item.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const DashboardPage({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'Dashboard',
      backgroundColor: Colors.blue,
    );
  }
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.black.withOpacity(0.03),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: SafeArea(child: _getTabBar()),
            ),
            body: _getTabBarPages()));
  }

  Widget _getTabBar() {
    return const TabBar(labelColor: Colors.white, tabs: [
      Tab(
        iconMargin: EdgeInsets.only(top: 5, bottom: 2),
        text: 'Accounts',
        icon: Icon(
          Icons.account_balance,
        ),
      ),
      Tab(
        iconMargin: EdgeInsets.only(top: 5, bottom: 2),
        text: 'Budgets',
        icon: Icon(
          Icons.ballot,
        ),
      ),
      Tab(
        iconMargin: EdgeInsets.only(top: 5, bottom: 2),
        text: 'Savings',
        icon: Icon(
          Icons.savings,
        ),
      ),
    ]);
  }

  Widget _getTabBarPages() {
    return TabBarView(children: <Widget>[
      AccountsPage(),
      BudgetsPage(),
      Container(color: Colors.blue)
    ]);
  }
}
