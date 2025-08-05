// transaction_model.dart
import 'package:hive/hive.dart';
import 'package:mactest/features/models/transaction.dart';

// helper: transaction_helper.dart
class TransactionHelper {
  static final _box = Hive.box<Transaction>('transactions');

  static Future<void> addTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }

  static List<Transaction> getAllTransactions() {
    return _box.values.toList();
  }

  static List<Transaction> getTransactionsByType(String type) {
    return _box.values.where((t) => t.type == type).toList();
  }

  static Future<void> deleteTransaction(String id) async {
    await _box.delete(id);
  }

  static Future<void> updateTransaction(
    String id,
    Transaction newTransaction,
  ) async {
    await _box.put(id, newTransaction);
  }

  static List<Transaction> filterByDateRange(DateTime start, DateTime end) {
    return _box.values
        .where(
          (t) =>
              t.date.isAfter(start.subtract(const Duration(days: 1))) &&
              t.date.isBefore(end.add(const Duration(days: 1))),
        )
        .toList();
  }
}

// // currency_settings.dart
// @HiveType(typeId: 1)
// class CurrencySettings extends HiveObject {
//   @HiveField(0)
//   final String symbol;

//   CurrencySettings({required this.symbol});
// }

// To generate adapters:
// flutter pub run build_runner build --delete-conflicting-outputs
