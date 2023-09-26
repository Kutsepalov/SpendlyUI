import 'package:flutter/animation.dart';
import 'package:spendly_ui/models/category_node.dart';
import 'package:spendly_ui/view/util/hex_color.dart';

class Category {
  final String id;
  final String name;
  final String icon;
  final Color color;
  final String? parentCategoryId;
  final List<Category>? childCategories;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.parentCategoryId,
    this.childCategories,
  });

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        icon = json['icon'],
        parentCategoryId = json['parentCategoryId'],
        color = HexColor.fromHex(json['color']),
        childCategories = (json['childCategories'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'icon': icon,
  //     'color': color.toHex(),
  //     'parentCategoryId': parentCategoryId,
  //     'note': note,
  //     'payee': payee,
  //     'type': type.name,
  //     'categoryId': categoryId,
  //     'category': category,
  //     'accountId': accountId,
  //     'account': account.toJson(),
  //     'creationDatetime': creationDatetime,
  //   };
  // }

  CategoryNode mapToTreeNode() {
    return _map(null);
  }

  CategoryNode _map(CategoryNode? parent) {
    CategoryNode current = CategoryNode(data: this, parent: parent);
    if (childCategories != null && childCategories!.isNotEmpty) {
      current.addAll(childCategories!.map((element) => element._map(current)));
    }
    return current;
  }
}
