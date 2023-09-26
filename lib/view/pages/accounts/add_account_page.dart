import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/view/widgets/dropdowns/account_type_dropdown.dart';
import 'package:spendly_ui/view/widgets/dropdowns/currency_dropdown.dart';
import 'package:spendly_ui/view/widgets/snack_bar.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:spendly_ui/view/widgets/value_form_field.dart';

class NewAccountPage extends StatefulWidget {
  const NewAccountPage({super.key, this.onAdd});

  final Function? onAdd;
  @override
  State<NewAccountPage> createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  final AccountClient _accountClient = AccountClient();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNameInputFieldController =
      TextEditingController();
  final TextEditingController _accountValueInputFieldController =
      TextEditingController();

  final AccountTypeDropdown accountTypeDropdown = AccountTypeDropdown();
  final CurrencyDropdown currencyDropdown = CurrencyDropdown();

  void addAccount() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSnackBar(context, 'Creating account...');

      Account account = Account(
        name: _accountNameInputFieldController.text,
        amount: double.parse(_accountValueInputFieldController.text),
        currency: currencyDropdown.selectedCurrency.name,
        type: accountTypeDropdown.selectedAccountType,
      );

      SpendlyResponse<Account> spendlyResponse =
          await _accountClient.createAccount(account);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        hideCurrentSnackBar(context);

        if (!spendlyResponse.hasError) {
          showSuccessSnackBar(context, 'Account created!');
          Navigator.pop(context);
        } else {
          showFailSnackBar(context, spendlyResponse.error ?? 'Error');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('New account', style: TextStyle(color: Colors.blue.shade50)),
        iconTheme: IconThemeData(color: Colors.blue.shade50),
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(elevation: 0.0),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            color: Colors.white,
            Icons.clear_rounded,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0.0),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addAccount();
                widget.onAdd?.call();
              }
            },
            child: const Icon(
              Icons.check,
              color: Colors.white,
              size: 26.0,
            ),
          ),
        ],
      ),
      body: Center(
        child: Tile(
            child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              _accountNameInputField(),
              _accountValueInputField(),
              accountTypeDropdown,
              currencyDropdown,
              _accountColorDropdown(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _accountNameInputField() {
    return ValueFormField(
      isRequired: true,
      controller: _accountNameInputFieldController,
      maxLength: 20,
      icon: const Icon(Icons.account_balance),
      labelText: 'Account name',
      helperText: 'Fill-in an account name, please',
      regex: r'^[A-Za-z0-9\s]+$',
      keyboardType: TextInputType.name,
    );
  }

  Widget _accountValueInputField() {
    return ValueFormField(
      isRequired: true,
      controller: _accountValueInputFieldController,
      icon: const Icon(Icons.attach_money),
      labelText: 'Initial value',
      helperText: 'Fill-in an account value, please',
      hintText: '0.00',
      regex: r'^-?\d+(?:[\.,]\d{1,2})?$',
      keyboardType: TextInputType.number,
    );
  }

  Widget _accountColorDropdown() {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          icon: Icon(Icons.color_lens),
          labelText: 'Account Color',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        value: 'Green',
        onChanged: (newValue) {},
        items: [
          DropdownMenuItem<String>(
            value: 'Green',
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Amber')),
              ],
            ),
          )
        ]);
  }
}
