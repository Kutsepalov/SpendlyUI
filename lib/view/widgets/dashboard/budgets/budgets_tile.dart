import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:spendly_ui/models/budget.dart';
import 'package:spendly_ui/view/pages/budgets/add_budget_page.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/dashboard/accounts_tile.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class BudgetsTile extends StatefulWidget {
  final List<Budget> budgets;

  const BudgetsTile({super.key, required this.budgets});

  @override
  State<StatefulWidget> createState() => _BudgetsTileState();
}

class _BudgetsTileState extends State<BudgetsTile> {
  @override
  Widget build(BuildContext context) {
    return Tile(
        child: Column(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 10, right: 5, left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'List of budgets',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_getSum(), style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
      GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 6.0,
          ),
          children: combine(
              widget.budgets.map((budget) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                  text: '${budget.name} ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: percentFormat(budget.proportion),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                          Text(
                            '${formatWithoutZero(budget.currency, budget.restAmount)} of ${formatWithoutZero(budget.currency, budget.plannedAmount)}',
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      FAProgressBar(
                        borderRadius: BorderRadius.circular(3),
                        currentValue: budget.restAmount,
                        maxValue: budget.plannedAmount,
                        backgroundColor:
                            budget.restAmount < 0 ? Colors.red : Colors.black26,
                        progressColor: _calculateColor(budget.proportion),
                        size: 8,
                      ),
                    ],
                  ),
                );
              }).toList(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBudgetPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'ADD BUDGET',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                    ),
                    Icon(
                      Icons.add_circle,
                      size: 16,
                      color: Colors.blueAccent,
                    )
                  ],
                ),
              )))
    ]));
  }

  List<Widget> combine(List<Widget> list, Widget object) {
    list.add(object);
    return list;
  }

  String _getSum() {
    double sumOfRest = 0;
    double sumOfPlanned = 0;
    for (var budget in widget.budgets) {
      sumOfRest += budget.restAmount;
      sumOfPlanned += budget.plannedAmount;
    }
    return 'Σ ₴${sumOfRest.toString()} / ${sumOfPlanned.toString()}';
  }

  Color _calculateColor(double value) {
    Color result = Colors.green;
    if (value < 0.1) {
      result = Colors.orange;
    }
    if (value < 0) {
      result = Colors.red;
    }
    return result;
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.7).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
