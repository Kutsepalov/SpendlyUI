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

class AccountsListPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  const AccountsListPage({super.key});

  @override
  State<StatefulWidget> createState() => _AccountsListPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: 'Accounts',
      backgroundColor: Colors.green,
    );
  }
}

class _AccountsListPageState extends State<AccountsListPage> {
  final AccountClient _accountClient = AccountClient();

  List<Account> _accounts = <Account>[];

  final int uploadMax = 50;
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    uploadData();
  }

  void uploadData() async {
    List<dynamic> data = await _accountClient.getAccounts();
    setState(() {
      _accounts = data.map((e) => Account.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts', style: TextStyle(color: Colors.blue.shade50)),
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
              itemCount: _accounts.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == _accounts.length) {
      return const CupertinoActivityIndicator();
    }
    Account account = _accounts[index];
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: account.color,
        child:
            Icon(Icons.wallet, color: lighten(account.color ?? Colors.amber)),
      ),
      title: Text(account.name),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(format(account.currency, account.amount),
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.7).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
