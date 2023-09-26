import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:spendly_ui/models/category.dart';

class CategoryNode extends TreeNode<Category> {
  CategoryNode({
    super.key,
    super.data,
    super.isExpanded,
    super.parent,
  });
}
