import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/models/category.dart';
import 'package:flutter/material.dart';
import 'package:spendly_ui/view/pages/home/navbar_item.dart';
import 'package:spendly_ui/view/util/hex_color.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class NotificationsListPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const NotificationsListPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationsListPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: 'Notifications',
      backgroundColor: Colors.green,
    );
  }
}

class _NotificationsListPageState extends State<NotificationsListPage> {
  List<Notification> _groups = <Notification>[];

  final int uploadMax = 50;
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    uploadData();
  }

  void uploadData() async {
    setState(() {
      _groups = [
        Notification(
            title: 'Invitation to Family',
            text:
                "Dear Max Kutsepalov, \nYou were invited to the group \"Family\" by Maryn Kovalska")
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups', style: TextStyle(color: Colors.blue.shade50)),
        iconTheme: IconThemeData(color: Colors.blue.shade50),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Tile(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey.shade200,
              ),
              itemBuilder: _itemBuilder,
              itemCount: _groups.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == _groups.length) {
      return const CupertinoActivityIndicator();
    }
    Notification notification = _groups[index];
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      onPressed: () {},
      child: ListTile(
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(notification.title),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${notification.text}',
                style: const TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.7).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

class Notification {
  final String? id;
  final String title;
  final String text;
  final bool? isRead;

  Notification({
    this.id,
    required this.title,
    required this.text,
    this.isRead,
  });
}
