import 'package:flutter/material.dart';

class AccountTypeDropdown extends StatefulWidget {
  AccountTypeDropdown({super.key});

  final List<String> accountTypes = [
    'General',
    'Cash',
  ];

  late String selectedAccountType = accountTypes.first;

  @override
  State<StatefulWidget> createState() => _AccountTypeDropdownState();
}

class _AccountTypeDropdownState extends State<AccountTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        icon: Icon(Icons.type_specimen),
        labelText: 'Account Type',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      value: widget.selectedAccountType,
      onChanged: (newValue) {
        setState(() {
          widget.selectedAccountType = newValue ?? widget.accountTypes.first;
        });
      },
      items: widget.accountTypes.map((String accountType) {
        return DropdownMenuItem<String>(
          value: accountType,
          child: Text(accountType),
        );
      }).toList(),
    );
  }
}
