import 'package:flutter/material.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/view/pages/accounts/add_account_page.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class AccountsTile extends StatefulWidget {
  final List<Account> accounts;
  final Function? onAdd;

  const AccountsTile({super.key, required this.accounts, this.onAdd});

  @override
  State<StatefulWidget> createState() => _AccountsTileState();
}

class _AccountsTileState extends State<AccountsTile> {
  @override
  Widget build(BuildContext context) {
    return Tile(
        child: Column(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'List of accounts',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Σ ${format('₴', _getSum())}',
                style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
      GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          children: combine(
              widget.accounts.map((account) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    backgroundColor: account.color,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        style: TextStyle(
                          color: lighten(account.color ?? Colors.black),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        format(account.currency, account.amount),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: lighten(account.color ?? Colors.black),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NewAccountPage(onAdd: widget.onAdd)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'ADD ACCOUNT',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 16,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              )))
    ]));
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.7).clamp(0.0, 1.0));

    return hslLight.toColor();
  }

  List<Widget> combine(List<Widget> list, Widget object) {
    list.add(object);
    return list;
  }

  double _getSum() {
    double sum = 0;
    for (var account in widget.accounts) {
      sum += account.amount;
    }
    return sum;
  }
}
