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

class GroupsListPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const GroupsListPage({super.key});

  @override
  State<StatefulWidget> createState() => _GroupsListPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: 'Groups',
      backgroundColor: Colors.green,
    );
  }
}

class _GroupsListPageState extends State<GroupsListPage> {
  List<Group> _groups = <Group>[];

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
        Group(name: 'Family', numberOfParticipants: 2, color: Colors.red)
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
    Group group = _groups[index];
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      onPressed: () {},
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: group.color,
          child:
              Icon(Icons.people, color: lighten(group.color ?? Colors.amber)),
        ),
        title: Text(group.name),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('${group.numberOfParticipants} participants',
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
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

class Group {
  final String? id;
  final String name;
  final int numberOfParticipants;
  final Color? color;

  Group({
    this.id,
    required this.name,
    required this.numberOfParticipants,
    this.color,
  });
}
