import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/view/util/money_formater.dart';

class AccountDropdown extends StatefulWidget {
  AccountDropdown({super.key});

  Account? selectedAccount;

  @override
  State<StatefulWidget> createState() => _AccountDropdownState();
}

class _AccountDropdownState extends State<AccountDropdown> {
  final AccountClient _accountClient = AccountClient();

  List<Account>? _accounts;

  Future<void> getData() async {
    List list = await _accountClient.getAccounts();
    _accounts = list.map((e) => Account.map(e)).cast<Account>().toList();
    widget.selectedAccount = _accounts?.first;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return DropdownButtonFormField<Account>(
            decoration: const InputDecoration(
              icon: Icon(Icons.wallet),
              labelText: 'Account',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
            value: widget.selectedAccount,
            onChanged: (newValue) {
              widget.selectedAccount = newValue ?? _accounts?.first;
            },
            items: _accounts!.map((Account account) {
              return DropdownMenuItem<Account>(
                value: account,
                child: SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 10.0,
                        width: 10.0,
                        decoration: BoxDecoration(
                          color: account.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(account.name)),
                      Text('(${format(account.currency, account.amount)})',
                          style: const TextStyle(color: Colors.black45)),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
