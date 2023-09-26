import 'package:flutter/material.dart';

class Budget {
  final String name;
  final double plannedAmount;
  final double restAmount;
  late double proportion;
  final String currency;
  final Color color;
  final IconData icon;

  Budget({
    required this.plannedAmount,
    required this.name,
    required this.currency,
    required this.color,
    required this.restAmount,
    required this.icon,
  }) {
    proportion = restAmount / plannedAmount;
  }
}
