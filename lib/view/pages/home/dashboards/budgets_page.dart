import 'package:flutter/material.dart';
import 'package:spendly_ui/models/budget.dart';
import 'package:spendly_ui/view/widgets/dashboard/budgets/bar_chart_tile.dart';
import 'package:spendly_ui/view/widgets/dashboard/budgets/budgets_tile.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class BudgetsPage extends StatefulWidget {
  BudgetsPage({super.key});

  final List<Budget> budgets = [
    Budget(
      name: 'Food',
      restAmount: 900.00,
      plannedAmount: 1500.00,
      currency: '₴',
      color: Colors.red,
      icon: Icons.food_bank_rounded,
    ),
    Budget(
        name: 'Entertaiment',
        restAmount: 145.00,
        plannedAmount: 600.00,
        currency: '₴',
        color: Colors.green,
        icon: Icons.add_reaction),
    Budget(
        name: 'Transportination',
        restAmount: 10.00,
        plannedAmount: 200.00,
        currency: '₴',
        color: Colors.green,
        icon: Icons.add_reaction),
    Budget(
        name: 'Gifts',
        restAmount: -20.00,
        plannedAmount: 200.00,
        currency: '₴',
        color: Colors.green,
        icon: Icons.add_reaction),
  ];

  @override
  State<BudgetsPage> createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 1200,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              BudgetsTile(
                budgets: widget.budgets,
              ),
              BarChartTile(
                budgets: widget.budgets,
              ),
            ],
          ),
        ));
  }
}
