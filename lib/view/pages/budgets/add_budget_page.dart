import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/view/widgets/dropdowns/account_type_dropdown.dart';
import 'package:spendly_ui/view/widgets/dropdowns/category_dropdown.dart';
import 'package:spendly_ui/view/widgets/dropdowns/currency_dropdown.dart';
import 'package:spendly_ui/view/widgets/snack_bar.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:spendly_ui/view/widgets/value_form_field.dart';

class AddBudgetPage extends StatefulWidget {
  const AddBudgetPage({super.key, this.onAdd});

  final Function? onAdd;
  @override
  State<AddBudgetPage> createState() => _AddBudgetPageState();
}

class _AddBudgetPageState extends State<AddBudgetPage> {
  final AccountClient _accountClient = AccountClient();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _accountNameInputFieldController =
      TextEditingController();
  final TextEditingController _accountValueInputFieldController =
      TextEditingController();

  final CurrencyDropdown currencyDropdown = CurrencyDropdown();
  final CategoryDropdown categoryDropdown = CategoryDropdown();

  void addBudget() async {
    if (_formKey.currentState!.validate()) {
      showLoadingSnackBar(context, 'Creating budget...');

      // Account account = Account(
      //   name: _accountNameInputFieldController.text,
      //   amount: double.parse(_accountValueInputFieldController.text),
      //   currency: currencyDropdown.selectedCurrency.name,
      //   type: '',
      // );

      // SpendlyResponse<Account> spendlyResponse =
      //     await _accountClient.createAccount(account);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        hideCurrentSnackBar(context);

        // if (!spendlyResponse.hasError) {
        showSuccessSnackBar(context, 'Budget created!');
        Navigator.pop(context);
        //   } else {
        //     showFailSnackBar(context, spendlyResponse.error ?? 'Error');
        //   }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add budget', style: TextStyle(color: Colors.blue.shade50)),
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
                addBudget();
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
              _budgetNameInputField(),
              _budgetValueInputField(),
              currencyDropdown,
              _budgetPeriodicityDropdown(),
              categoryDropdown,
              _groupDropdown(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _budgetNameInputField() {
    return ValueFormField(
      isRequired: true,
      controller: _accountNameInputFieldController,
      maxLength: 20,
      icon: const Icon(Icons.account_balance),
      labelText: 'Budget name',
      helperText: 'Fill-in an budget name, please',
      regex: r'^[A-Za-z0-9\s]+$',
      keyboardType: TextInputType.name,
    );
  }

  Widget _budgetValueInputField() {
    return ValueFormField(
      isRequired: true,
      controller: _accountValueInputFieldController,
      icon: const Icon(Icons.attach_money),
      labelText: 'Amount',
      helperText: 'Fill-in an budget value, please',
      hintText: '0.00',
      regex: r'^-?\d+(?:[\.,]\d{1,2})?$',
      keyboardType: TextInputType.number,
    );
  }

  Widget _budgetPeriodicityDropdown() {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          icon: Icon(Icons.timelapse),
          labelText: 'Periodicity',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        value: 'Monthly',
        onChanged: (newValue) {},
        items: [
          DropdownMenuItem<String>(
            value: 'Daily',
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Daily')),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Weekly',
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Weekly')),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Monthly',
            child: Row(
              children: [
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 5),
                //   height: 10.0,
                //   width: 10.0,
                //   decoration: BoxDecoration(
                //     color: Colors.amber,
                //     shape: BoxShape.circle,
                //   ),
                // ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Monthly')),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Annual',
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Annual')),
              ],
            ),
          )
        ]);
  }

  Widget _groupDropdown() {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          icon: Icon(Icons.group),
          labelText: 'User Groups',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        value: 'No Color',
        onChanged: (newValue) {},
        items: [
          DropdownMenuItem<String>(
            value: 'No Color',
            child: Row(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Select a group')),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: 'Green',
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Family')),
              ],
            ),
          )
        ]);
  }
}
