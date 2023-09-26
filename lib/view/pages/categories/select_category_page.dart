import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:spendly_ui/core/clients/category_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/models/category.dart';
import 'package:spendly_ui/models/category_node.dart';
import 'package:spendly_ui/view/pages/home/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:spendly_ui/view/util/money_formater.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class SelectCategoryPage extends StatefulWidget
    implements NavigationBarItemProvidable {
  final Function(Category)? onTap;

  const SelectCategoryPage({super.key, this.onTap});

  @override
  State<StatefulWidget> createState() => _SelectCategoryPageState();

  @override
  BottomNavigationBarItem getNavigationBarItem() {
    return const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Records',
      backgroundColor: Colors.orange,
    );
  }
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  final CategoryClient _categoryClient = CategoryClient();

  List<Category> _categories = <Category>[];

  @override
  void initState() {
    super.initState();
    uploadData();
  }

  void uploadData() async {
    SpendlyResponse<List<Category>> response =
        await _categoryClient.getCategories();
    if (!response.hasError) {
      setState(() {
        _categories = response.data ?? [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories', style: TextStyle(color: Colors.blue.shade50)),
        iconTheme: IconThemeData(color: Colors.blue.shade50),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Tile(
            child: TreeView.simple<Category>(
              expansionBehavior: ExpansionBehavior.scrollToLastChild,
              showRootNode: false,
              expansionIndicator: const ExpansionIndicator(
                expandIcon: Icon(Icons.expand_more),
                collapseIcon: Icon(Icons.expand_less),
              ),
              tree: _categories.map((e) => e.mapToTreeNode()).fold(
                  TreeNode.root(), (value, element) => value..add(element)),
              builder: _itemBuilder,
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(
      BuildContext context, int level, TreeNode<Category> node) {
    Category category = node.data!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(category.name),
        onTap: () {
          widget.onTap?.call(category);
          Navigator.pop(context);
        },
        leading: CircleAvatar(
          backgroundColor: category.color,
          child: Icon(Icons.heart_broken, color: lighten(category.color)),
        ),
      ),
    );
  }

  Color lighten(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness((hsl.lightness + 0.45).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
