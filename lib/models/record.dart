import 'package:flutter/material.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/models/category.dart';
import 'package:spendly_ui/models/enums/record_type.dart';
import 'package:spendly_ui/view/util/hex_color.dart';

class Record {
  final int? id;
  final double amount;
  final String currency;
  final double targetAmount;
  final String targetCurrency;
  final String? note;
  final String? payee;
  final RecordType type;
  final String? categoryId;
  final Category category;
  final String? accountId;
  final Account account;
  final DateTime creationDatetime;

  Record(
      {this.id,
      required this.amount,
      required this.currency,
      required this.targetAmount,
      required this.targetCurrency,
      this.note,
      this.payee,
      required this.type,
      this.categoryId,
      required this.category,
      required this.creationDatetime,
      this.accountId,
      required this.account});

  Record.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = (json['amount'] as num).toDouble(),
        currency = json['currency'],
        targetAmount = (json['targetAmount'] as num).toDouble(),
        targetCurrency = json['targetCurrency'],
        note = json['note'],
        payee = json['payee'],
        type = RecordType.getByName(json['type']),
        categoryId = json['categoryId'],
        category = Category.fromJson(json['category']),
        creationDatetime = DateTime.parse(json['creationDatetime']),
        accountId = json['accountId'],
        account = Account.fromJson(json['account']);

  Record.fromJsonSmall(Map<String, dynamic> json)
      : id = json['id'],
        amount = (json['amount'] as num).toDouble(),
        currency = json['currency'],
        targetAmount = (json['targetAmount'] as num).toDouble(),
        targetCurrency = json['targetCurrency'],
        note = json['note'],
        payee = json['payee'],
        type = RecordType.getByName(json['type']),
        categoryId = json['categoryId'],
        category =
            Category(id: "id", name: "name", icon: "icon", color: Colors.black),
        creationDatetime = DateTime.parse(json['creationDatetime']),
        accountId = json['accountId'],
        account =
            Account(name: "name", type: "type", amount: 0, currency: "UAH");

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount.toString(),
      'currency': currency,
      'targetAmount': targetAmount.toString(),
      'targetCurrency': targetCurrency,
      'note': note,
      'payee': payee,
      'type': type.name,
      'categoryId': categoryId,
      'accountId': accountId,
      'account': account.toJson(),
    };
  }
}
