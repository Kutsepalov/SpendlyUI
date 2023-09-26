import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:spendly_ui/core/clients/account_client.dart';
import 'package:spendly_ui/core/clients/category_client.dart';
import 'package:spendly_ui/models/account.dart';
import 'package:spendly_ui/models/category.dart';
import 'package:spendly_ui/view/pages/categories/select_category_page.dart';
import 'package:spendly_ui/view/util/hex_color.dart';
import 'package:spendly_ui/view/util/money_formater.dart';

class CategoryDropdown extends StatefulWidget {
  CategoryDropdown({super.key});

  Category? selectedCategory;

  @override
  State<StatefulWidget> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final CategoryClient _categoryClient = CategoryClient();

  // Future<void> getData() async {
  //   List list = await _accountClient.getAccounts();
  //   _accounts = list.map((e) => Account.map(e)).cast<Account>().toList();
  //   widget.selectedAccount = _accounts?.first;
  // }

  List<Widget> chipWidget() {
    List<Widget> list = [];
    if (widget.selectedCategory != null) {
      Category category = widget.selectedCategory!;
      list.add(Chip(
        label: Text(
          category.name,
          style: TextStyle(color: lighten(category.color)),
        ),
        backgroundColor: category.color,
        avatar: Icon(
          Icons.heart_broken,
          color: lighten(category.color),
        ),
        onDeleted: () {
          setState(() {
            widget.selectedCategory = null;
          });
        },
        deleteIconColor: lighten(category.color),
      ));
    } else {
      list.add(Text(
        'Choose a category, please',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(
              CarbonIcons.chart_pie,
              color:
                  widget.selectedCategory != null ? Colors.blue : Colors.grey,
              size: 25,
            ),
          ),
          Column(
            children: chipWidget(),
          ),
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          ),
          ElevatedButton(
            style: OutlinedButton.styleFrom(
              alignment: Alignment.center,
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.blueAccent,
              ),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCategoryPage(
                    onTap: (category) {
                      setState(() {
                        widget.selectedCategory = category;
                      });
                    },
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'CHOOSE CATEGORY',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 13),
                ),
                Icon(
                  Icons.add_circle,
                  size: 16,
                  color: Colors.blueAccent,
                )
              ],
            ),
          )
        ],
        // subtitle: Text('Choose category, please'),
        // shape: Border(
        //   bottom: BorderSide(),
        // ),
        // title: Row(
        //     children:
        //       ..add(Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //         child: ,
        //       ))),
      ),
    );
  }
}
