import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/record_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/enums/record_type.dart';
import 'package:spendly_ui/models/record.dart';
import 'package:spendly_ui/view/widgets/dropdowns/account_dropdown.dart';
import 'package:spendly_ui/view/widgets/dropdowns/category_dropdown.dart';
import 'package:spendly_ui/view/widgets/dropdowns/currency_dropdown.dart';
import 'package:spendly_ui/view/widgets/snack_bar.dart';
import 'package:spendly_ui/view/widgets/tile.dart';
import 'package:spendly_ui/view/widgets/value_form_field.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({super.key, this.onCreate});

  final Function(Record)? onCreate;
  @override
  State<AddRecordPage> createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  List<Widget> recordTypes = <Widget>[
    Text(RecordType.income.displayName),
    Text(RecordType.expense.displayName),
    Text(RecordType.transfer.displayName)
  ];

  var recordTypeColors = {
    0: Colors.green,
    1: Colors.red,
    2: Colors.amberAccent
  };

  final RecordClient _recordClient = RecordClient();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionInputFieldController =
      TextEditingController();
  final TextEditingController _recordValueInputFieldController =
      TextEditingController();
  final TextEditingController _recordTargetValueInputFieldController =
      TextEditingController();

  final AccountDropdown accountDropdown = AccountDropdown();
  final CurrencyDropdown currencyDropdown = CurrencyDropdown();
  final CategoryDropdown categoryDropdown = CategoryDropdown();

  final List<bool> _selectedRecordTypes = <bool>[true, false, false];

  void addRecord() async {
    if (_formKey.currentState!.validate() &&
        categoryDropdown.selectedCategory != null) {
      showLoadingSnackBar(context, 'Creating record...');

      Record record = Record(
          amount: double.parse(_recordValueInputFieldController.text),
          currency: currencyDropdown.selectedCurrency.name,
          targetAmount:
              double.parse(_recordTargetValueInputFieldController.text),
          targetCurrency: accountDropdown.selectedAccount!.currency,
          type: RecordType.values.elementAt(_selectedRecordTypes.indexOf(true)),
          categoryId: categoryDropdown.selectedCategory!.id,
          category: categoryDropdown.selectedCategory!,
          accountId: accountDropdown.selectedAccount!.id,
          account: accountDropdown.selectedAccount!,
          creationDatetime: DateTime.now());

      SpendlyResponse<Record> spendlyResponse =
          await _recordClient.createRecord(record);

      hideCurrentSnackBar(context);

      if (!spendlyResponse.hasError) {
        showSuccessSnackBar(context, 'Record created!');
        Navigator.pop(context);
        widget.onCreate?.call(record);
      } else {
        showFailSnackBar(context, spendlyResponse.error ?? 'Error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Record', style: TextStyle(color: Colors.blue.shade50)),
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
                addRecord();
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
              _recordTypeToggleButtons(),
              accountDropdown,
              _recordValueInputField(),
              categoryDropdown,
              currencyDropdown,
              _recordTargetValueInputField(),
              _descriptionInputField(),
            ],
          ),
        )),
      ),
    );
  }

  Widget _descriptionInputField() {
    return ValueFormField(
      controller: _descriptionInputFieldController,
      maxLength: 200,
      icon: const Icon(Icons.account_balance),
      labelText: 'Description',
      helperText: 'Fill-in a description, please',
      regex: r'^[A-Za-z0-9\s]+$',
      keyboardType: TextInputType.text,
    );
  }

  Widget _recordValueInputField() {
    return ValueFormField(
      controller: _recordValueInputFieldController,
      icon: const Icon(Icons.attach_money),
      labelText: 'Record value',
      helperText: 'Fill-in a record value, please',
      hintText: '1.00',
      regex: r'^(?!0(?:[.,]0+)?$)\d+(?:[.,]\d{1,2})?$',
      keyboardType: TextInputType.number,
      isRequired: true,
    );
  }

  Widget _recordTargetValueInputField() {
    return ValueFormField(
      controller: _recordTargetValueInputFieldController,
      icon: const Icon(Icons.attach_money),
      labelText: 'Record target value',
      helperText: 'Please, enter a value after convertion or leave empty',
      hintText: '1.00',
      regex: r'^(?!0(?:[.,]0+)?$)\d+(?:[.,]\d{1,2})?$',
      keyboardType: TextInputType.number,
    );
  }

  Widget _recordTypeToggleButtons() {
    return ToggleButtons(
      direction: Axis.horizontal,
      onPressed: (int index) {
        setState(() {
          for (int i = 0; i < _selectedRecordTypes.length; i++) {
            _selectedRecordTypes[i] = i == index;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      selectedBorderColor: recordTypeColors[_selectedRecordTypes.indexOf(true)],
      selectedColor: Colors.white,
      fillColor: recordTypeColors[_selectedRecordTypes.indexOf(true)],
      color: Colors.black54,
      constraints: BoxConstraints(
        minHeight: 35.0,
        minWidth: _calculateWidth(context),
        maxWidth: 300.0,
      ),
      isSelected: _selectedRecordTypes,
      children: recordTypes,
    );
  }

  double _calculateWidth(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 5;
    double? maxWidth = 300.0;
    if (width > maxWidth) {
      width = maxWidth;
    }
    return width;
  }
}
