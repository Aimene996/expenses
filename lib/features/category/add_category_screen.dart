import 'package:flutter/material.dart';
import 'package:mactest/features/category/add_custom_category.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String? selectedCategory;

  // All categories from both expense and income sections
  final List<CategoryItem> allCategories = [
    // Expense Categories
    CategoryItem(
      title: 'Groceries',
      icon: Icons.shopping_cart_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Transportation',
      icon: Icons.directions_car_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Utilities',
      icon: Icons.receipt_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Mobile & Internet',
      icon: Icons.wifi_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Rent/Mortgage',
      icon: Icons.home_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Healthcare',
      icon: Icons.local_hospital_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Clothing & Shoes',
      icon: Icons.checkroom_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Entertainment',
      icon: Icons.movie_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Education',
      icon: Icons.school_outlined,
      type: 'Expense',
    ),
    CategoryItem(title: 'Home', icon: Icons.home_filled, type: 'Expense'),
    CategoryItem(
      title: 'Gifts',
      icon: Icons.card_giftcard_outlined,
      type: 'Expense',
    ),
    CategoryItem(title: 'Pets', icon: Icons.pets_outlined, type: 'Expense'),
    CategoryItem(
      title: 'Sports & Fitness',
      icon: Icons.fitness_center_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Children',
      icon: Icons.child_friendly_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Insurances',
      icon: Icons.security_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Taxes & Fines',
      icon: Icons.receipt_long_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Travel',
      icon: Icons.flight_takeoff_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Business Expenses',
      icon: Icons.business_center_outlined,
      type: 'Expense',
    ),
    CategoryItem(
      title: 'Charity',
      icon: Icons.volunteer_activism_outlined,
      type: 'Expense',
    ),

    // Income Categories
    CategoryItem(
      title: 'Salary',
      icon: Icons.attach_money_outlined,
      type: 'Income',
    ),
    CategoryItem(
      title: 'Bonuses',
      icon: Icons.monetization_on_outlined,
      type: 'Income',
    ),
    CategoryItem(title: 'Freelance', icon: Icons.work_outline, type: 'Income'),
    CategoryItem(
      title: 'Gifts',
      icon: Icons.card_giftcard_outlined,
      type: 'Income',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1D21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Category',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  final isSelected = selectedCategory == category.title;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // If the same category is tapped again, deselect it
                        if (selectedCategory == category.title) {
                          selectedCategory = null;
                        } else {
                          selectedCategory = category.title;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF374151)
                            : const Color(0xFF2A2D31),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected
                            ? Border.all(
                                color: const Color(0xFF3B82F6),
                                width: 2,
                              )
                            : null,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Icon(category.icon, color: Colors.white, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                category.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Add Custom Category Button
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.only(bottom: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Handle add custom category
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddCustomCategory(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF374151),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Add Custom Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Select Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: selectedCategory != null
                    ? () {
                        // Handle category selection
                        Navigator.pop(context, selectedCategory);
                        print('Selected Category: $selectedCategory');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedCategory != null
                      ? const Color(0xFFE5E7EB)
                      : const Color(0xFF4B5563),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Select Category',
                  style: TextStyle(
                    color: selectedCategory != null
                        ? const Color(0xFF1A1D21)
                        : const Color(0xFF9CA3AF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final IconData icon;
  final String type;

  CategoryItem({required this.title, required this.icon, required this.type});
}
