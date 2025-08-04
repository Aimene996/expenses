import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mactest/features/models/transaction.dart';
import 'package:mactest/features/models/custom_category.dart'; // ⬅️ NEW
import 'package:mactest/features/Feed/navigation_tab_bar.dart';
import 'package:mactest/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  // Register Hive adapters
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CustomCategoryAdapter()); // ⬅️ NEW

  // Open Hive boxes
  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CustomCategory>('customCategories'); // ⬅️ NEW

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MacTest',
      theme: AppTheme.darkTheme,
      home: const NavigationTabBar(),
    );
  }
}
