import 'package:flutter/material.dart';
import 'package:spendly_ui/view/util/hex_color.dart';

class Account {
  final String? id;
  final String name;
  final String type;
  final double amount;
  final String currency;
  final Color? color;

  Account({
    this.id,
    required this.name,
    required this.type,
    required this.amount,
    required this.currency,
    this.color,
  });

  static Account map(dynamic data) {
    return Account(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      amount: data['amount'],
      currency: data['currency'],
      color: HexColor.fromHex(data['color']),
    );
  }

  Account.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        amount = (json['amount'] as num).toDouble(),
        currency = json['currency'],
        color = HexColor.fromHex(json['color']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'amount': amount,
      'currency': currency,
      'color': Colors.amber.toHex(),
    };
  }
}
