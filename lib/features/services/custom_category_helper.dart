import 'package:hive/hive.dart';
import 'package:mactest/features/models/custom_category.dart';

class CustomCategoryHelper {
  static const String _boxName = 'customCategories';

  /// Open the Hive box (should be called once, preferably at app startup)
  static Future<void> openBox() async {
    await Hive.openBox<CustomCategory>(_boxName);
  }

  /// Get the box instance
  static Box<CustomCategory> _getBox() {
    return Hive.box<CustomCategory>(_boxName);
  }

  /// Add a new custom category
  static Future<void> addCustomCategory(CustomCategory category) async {
    final box = _getBox();
    await box.add(category);
  }

  /// Get all saved custom categories
  static List<CustomCategory> getAllCustomCategories() {
    final box = _getBox();
    return box.values.toList();
  }

  /// Delete a category by its key
  static Future<void> deleteCategory(int key) async {
    final box = _getBox();
    await box.delete(key);
  }

  /// Clear all saved categories (optional for reset)
  static Future<void> clearAll() async {
    final box = _getBox();
    await box.clear();
  }
}
