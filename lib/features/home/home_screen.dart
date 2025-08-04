import 'package:flutter/material.dart';
import 'package:mactest/features/services/data_service.dart';
import 'package:mactest/features/transactions/add_new_transaction.dart';
import 'package:mactest/features/models/transaction.dart';

const TextStyle sectionTitleStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  fontFamily: 'inter',
);

const TextStyle cardTitleStyle = TextStyle(fontSize: 16, color: Colors.white);

const TextStyle cardValueStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const TextStyle subtitleStyle = TextStyle(
  fontSize: 14,
  color: Color(0xFF9EABBA),
);

const TextStyle amountTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> allTransactions = [];
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  void _loadTransactions() {
    final transactions = TransactionHelper.getAllTransactions();
    double income = 0;
    double expense = 0;

    for (var t in transactions) {
      if (t.type == 'income') {
        income += t.amount;
      } else if (t.type == 'expense') {
        expense += t.amount;
      }
    }

    setState(() {
      allTransactions = transactions;
      totalIncome = income;
      totalExpense = expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.0;
    final cardWidth = (screenWidth - (horizontalPadding * 3)) / 2;
    final savingsCardWidth = screenWidth - (horizontalPadding * 2);

    return Scaffold(
      appBar: AppBar(centerTitle: true, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          children: [
            _sectionHeader('Overview', horizontalPadding),
            Container(
              height: 268,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatCard(
                        '\$${totalIncome.toStringAsFixed(2)}',
                        'Income',
                        cardWidth,
                      ),
                      _buildStatCard(
                        '\$${totalExpense.toStringAsFixed(2)}',
                        'Expenses',
                        cardWidth,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: savingsCardWidth.clamp(300.0, 400.0),
                    height: 120,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF293038),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Savings', style: cardTitleStyle),
                        const SizedBox(height: 8),
                        Text(
                          '\$${(totalIncome - totalExpense).toStringAsFixed(2)}',
                          style: cardValueStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _sectionHeader('Latest', horizontalPadding),
            ..._buildLatestTransactions(horizontalPadding),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 112,
        height: 56,
        child: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddNewTransaction(),
              ),
            );
            _loadTransactions();
          },
          icon: const Icon(Icons.add, size: 24, color: Colors.white),
          label: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Add',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 8,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _sectionHeader(String title, double padding) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(
        top: 20,
        bottom: 12,
        left: padding,
        right: padding,
      ),
      child: Text(title, style: sectionTitleStyle),
    );
  }

  Widget _buildStatCard(String value, String title, double cardWidth) {
    return Container(
      width: cardWidth.clamp(150.0, 200.0),
      height: 110,
      decoration: BoxDecoration(
        color: const Color(0xFF293038),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: cardTitleStyle),
          const SizedBox(height: 8),
          Text(value, style: cardValueStyle),
        ],
      ),
    );
  }

  List<Widget> _buildLatestTransactions(double horizontalPadding) {
    final latest = List<Transaction>.from(allTransactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    final latestThree = latest.take(3).toList();

    return latestThree.map((transaction) {
      return Dismissible(
        key: Key(transaction.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) {
          TransactionHelper.deleteTransaction(transaction.id);
          _loadTransactions();
        },
        child: _buildTransactionRow(
          transaction.category,
          transaction.note,
          (transaction.type == 'expense' ? '-' : '+') +
              '\$${transaction.amount.toStringAsFixed(2)}',
          Icons.shopping_bag_outlined,
          horizontalPadding,
        ),
      );
    }).toList();
  }

  Widget _buildTransactionRow(
    String title,
    String subtitle,
    String price,
    IconData icon,
    double horizontalPadding,
  ) {
    return Container(
      width: double.infinity,
      height: 72,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF293038),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        style: subtitleStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(price, style: amountTextStyle),
        ],
      ),
    );
  }
}
