import 'package:spendly_ui/view/pages/home/navbar_item.dart';
import 'package:spendly_ui/view/pages/records/add_record_page.dart';
import 'package:spendly_ui/view/widgets/bottom_navbar.dart';
import 'package:spendly_ui/view/widgets/records/add_record_dialog.dart';
import 'package:spendly_ui/view/widgets/spendly_drawer.dart';
import 'package:flutter/material.dart';
import 'package:spendly_ui/view/pages/home/dashboards/dashboard_page.dart';
import 'package:spendly_ui/view/pages/records/records_page.dart';
import 'package:spendly_ui/view/pages/home/statistics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Widget> screens = [
    const DashboardPage(),
    const RecordsPage(),
    const StatisticsPage(),
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Home', style: TextStyle(color: Colors.blue.shade50)),
          iconTheme: IconThemeData(color: Colors.blue.shade50),
          elevation: _getElevation(),
        ),
        drawer: SpendlyDrawer(),
        floatingActionButton: FloatingActionButton(
          heroTag: "x",
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddRecordPage(onCreate: ((record) {
                        setState(() {});
                      }))),
            );
          },
        ),
        body: PageView(
          allowImplicitScrolling: true,
          onPageChanged: _onPageChanged,
          controller: _pageController,
          children: screens,
        ),
        bottomNavigationBar: SpendlyBottomNavigationBar(
          screens:
              screens.map((e) => e as NavigationBarItemProvidable).toList(),
          pageController: _pageController,
          currentIndex: _currentIndex,
          onTap: _onTap,
        ),
      );

  double _getElevation() {
    if (_currentIndex != 0) {
      return 5.0;
    } else {
      return 0;
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _onTap(index) => setState(() {
        _currentIndex = index;
        _pageController.animateToPage(_currentIndex,
            duration: const Duration(microseconds: 200), curve: Curves.linear);
      });

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Login'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.account_box),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Message',
                      icon: Icon(Icons.message),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: null,
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
