import 'package:flutter/material.dart';
import 'package:mactest/features/models/transaction.dart';
import 'package:mactest/features/services/data_service.dart';
import 'package:mactest/features/transactions/add_new_transaction.dart';
import 'package:intl/intl.dart';

class FakeTransaction extends StatefulWidget {
  const FakeTransaction({super.key});

  @override
  State<FakeTransaction> createState() => _FakeTransactionState();
}

class _FakeTransactionState extends State<FakeTransaction> {
  Map<String, List<Transaction>> groupedTransactions = {};

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    final all = TransactionHelper.getAllTransactions();

    // Group by "Month Year"
    final Map<String, List<Transaction>> grouped = {};

    for (var tx in all) {
      final key = DateFormat('MMMM yyyy').format(tx.date); // e.g., March 2025
      grouped.putIfAbsent(key, () => []).add(tx);
    }

    setState(() {
      groupedTransactions = grouped;
    });
  }

  Future<void> _deleteTransaction(String id) async {
    await TransactionHelper.deleteTransaction(id);
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Extracted text styles
    const titleStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    const subtitleStyle = TextStyle(
      color: Color(0xFF9EABBA),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    const amountStyle = TextStyle(
      fontFamily: 'Inter',
      color: Colors.white54,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D21),
        elevation: 0,
        title: const Text(
          'Transactions',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddNewTransaction()),
              );
              _loadTransactions(); // refresh after adding
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        child: Column(
          children: groupedTransactions.entries.map((entry) {
            final header = entry.key;
            final transactions = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Group header
                Container(
                  height: 84,
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 44, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        header.split(' ')[0], // Month
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        header.split(' ')[1], // Year
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // List of transactions for that month
                ListView.builder(
                  itemCount: transactions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final tx = transactions[index];

                    return Dismissible(
                      key: Key(tx.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) => _deleteTransaction(tx.id),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: Container(
                          width: screenWidth * 0.1,
                          height: screenWidth * 0.1,
                          decoration: BoxDecoration(
                            color: const Color(0xFF293038),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(tx.category, style: titleStyle),
                        subtitle: Text(tx.note, style: subtitleStyle),
                        trailing: Text(
                          tx.type == 'expense'
                              ? '-${tx.amount}'
                              : '+${tx.amount}',
                          style: amountStyle,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
