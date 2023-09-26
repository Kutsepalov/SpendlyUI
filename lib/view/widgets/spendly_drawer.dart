import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/core/clients/user_client.dart';
import 'package:spendly_ui/models/user.dart';
import 'package:spendly_ui/view/pages/accounts/accounts_list_page.dart';
import 'package:spendly_ui/view/pages/auth/authentication_page.dart';
import 'package:spendly_ui/view/pages/categories/categories_page.dart';
import 'package:spendly_ui/view/pages/groups/groups_list_page.dart';
import 'package:spendly_ui/view/pages/home/dashboards/accounts_page.dart';
import 'package:spendly_ui/view/pages/notifications/notifications_list_page.dart';

class SpendlyDrawer extends StatefulWidget {
  const SpendlyDrawer({super.key});

  @override
  State<SpendlyDrawer> createState() => _SpendlyDrawerState();
}

class _SpendlyDrawerState extends State<SpendlyDrawer> {
  final UserClient _userClient = UserClient();

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(children: [
          SizedBox(
            height: 100.0,
            child: FutureBuilder(
              future: _userClient.getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  final SpendlyResponse<User> data =
                      snapshot.data as SpendlyResponse<User>;
                  return _buildDrawerHeader(data.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          ..._drawerItems([
            _DrawerItem(
              text: 'Home',
              icon: Icons.home,
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _DrawerItem(
              text: 'Notifications',
              icon: Icons.notifications,
              color: Colors.green,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsListPage()),
                );
              },
            ),
          ]),
          const Divider(
            color: Colors.grey,
            thickness: 0.3,
          ),
          ..._drawerItems([
            _DrawerItem(
              text: 'Accounts',
              icon: Icons.account_balance,
              color: Colors.orange,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountsListPage()),
                );
              },
            ),
            _DrawerItem(
              text: 'Budgets',
              icon: Icons.ballot,
              color: Colors.cyan,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _DrawerItem(
              text: 'Savings',
              icon: Icons.savings,
              color: Colors.red,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _DrawerItem(
              text: 'Categories',
              icon: CarbonIcons.category_new,
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategoriesPage()),
                );
              },
            ),
            _DrawerItem(
              text: 'Groups',
              icon: CarbonIcons.group,
              color: Colors.green,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GroupsListPage()),
                );
              },
            ),
          ]),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(
                  color: Colors.grey,
                  thickness: 0.3,
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: const Text('Logout'),
                  onTap: _logout,
                ),
              ],
            ),
          ),
        ]),
      );

  List<ListTile> _drawerItems(List<_DrawerItem> items) {
    return items.map((e) {
      return ListTile(
        leading: Icon(e.icon, color: e.color),
        title: Text(e.text),
        onTap: e.onTap,
      );
    }).toList();
  }

  Future<void> _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(jwtKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthenticationPage(),
          ));
    });
  }

  DrawerHeader _buildDrawerHeader(User user) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          stops: const [0.25, 0.5, 0.75, 1],
          colors: [
            Colors.blue[700]!,
            Colors.blue[600]!,
            Colors.blue[500]!,
            Colors.blue[400]!,
          ],
        ),
        color: Colors.blue,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: CircleAvatar(
              child: Text(user.getInitials()),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.getFullName(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                user.username!,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DrawerItem {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _DrawerItem({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
