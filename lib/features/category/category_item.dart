// All categories from both expense and income sections
import 'package:flutter/material.dart';
import 'package:mactest/features/category/add_category_screen.dart';

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
