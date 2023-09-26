import 'package:flutter/material.dart';
import 'package:spendly_ui/models/enums/currency.dart';

class CurrencyDropdown extends StatefulWidget {
  CurrencyDropdown({super.key});
  Currency selectedCurrency = Currency.UAH;

  @override
  State<StatefulWidget> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: const InputDecoration(
        icon: Icon(Icons.attach_money),
        labelText: 'Currency',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      value: widget.selectedCurrency.name,
      onChanged: (newValue) {
        setState(() {
          widget.selectedCurrency = Currency.getByName(newValue, Currency.UAH);
        });
      },
      items: Currency.values.map((currency) {
        return DropdownMenuItem<String>(
          value: currency.name,
          child: Text('${currency.country} (${currency.name})',
              overflow: TextOverflow.ellipsis),
        );
      }).toList(),
    );
  }
}
