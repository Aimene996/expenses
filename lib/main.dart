import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mactest/features/models/currency.dart';
import 'package:mactest/features/providers/currency_provider.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mactest/features/models/transaction.dart';
import 'package:mactest/features/models/custom_category.dart'; // ⬅️ NEW
import 'package:mactest/features/Feed/navigation_tab_bar.dart';
import 'package:mactest/theme/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);

  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(CustomCategoryAdapter());
  Hive.registerAdapter(CurrencyAdapter());

  await Hive.openBox<Transaction>('transactions');
  await Hive.openBox<CustomCategory>('customCategories');
  await Hive.openBox<Currency>('currencyBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => CurrencyProvider(),
      child: const MyApp(),
    ),
  );
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
