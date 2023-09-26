import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/view/widgets/charts/doughnat_chart_tile.dart';
import 'package:spendly_ui/view/widgets/charts/period_to_period_comprasion_chart_tile.dart';
import 'package:spendly_ui/view/widgets/charts/spline_chart_tile.dart';
import 'package:spendly_ui/view/widgets/dashboard/accounts_tile.dart';

class AccountsPage extends StatefulWidget {
  AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final AccountClient _accountClient = AccountClient();

  List<Account> _accounts = [];

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
    return SingleChildScrollView(
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                AccountsTile(accounts: _accounts, onAdd: uploadData),
                const SplineChartTile(),
                const DoughnatChartTile(),
                const PeriodToPeriodComprasionChartTile(),
              ],
            ),
          )),
    );
  }
}
