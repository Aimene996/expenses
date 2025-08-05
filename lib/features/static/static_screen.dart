import 'package:flutter/material.dart';
import 'package:mactest/features/models/transaction.dart';
import 'package:mactest/features/providers/currency_provider.dart';
import 'package:mactest/features/services/data_service.dart';
import 'package:mactest/features/static/widgets/chart.dart';
import 'package:mactest/features/static/widgets/drop_down_button.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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

  static const double _verticalSpacing = 16.0;

  Widget _buildTabContent({
    required bool isExpenseTab,
    required double horizontalPadding,
    required double dropdownHeight,
    required double chartHeight,
    required double screenHeight,
    required String currencySymbol,
  }) {
    final filteredTransactions = allTransactions
        .where((tx) => tx.type == (isExpenseTab ? 'expense' : 'income'))
        .toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: _verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              isExpenseTab ? "Total Expenses" : "Income View",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: _verticalSpacing),
          Container(
            height: dropdownHeight.clamp(50.0, 80.0),
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: const DropdownButtonExample(),
          ),
          const SizedBox(height: _verticalSpacing),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpenseTab ? 'Expense' : 'Income',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isExpenseTab
                      ? '$currencySymbol${totalExpense.toStringAsFixed(0)}'
                      : '$currencySymbol${totalIncome.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: _verticalSpacing),
                SizedBox(
                  height: chartHeight.clamp(180.0, 250.0),
                  width: double.infinity,
                  child: ChartWidget(
                    selectedMonth: 'August',
                    showDimensions: true,
                    transactionType: isExpenseTab ? 'Expense' : 'Income',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: _verticalSpacing),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Text(
              isExpenseTab ? "Expenses By Category" : "Income By Category",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: _verticalSpacing),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpenseTab ? 'Expense' : 'Income',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isExpenseTab
                      ? '$currencySymbol${totalExpense.toStringAsFixed(0)}'
                      : '$currencySymbol${totalIncome.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'August',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: _verticalSpacing),
                SizedBox(
                  height: screenHeight * 0.4,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final tx = filteredTransactions[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 4.0,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  tx.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    height: 22 / 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              Container(
                                height: 28.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Text(
                                  '$currencySymbol${tx.amount.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    height: 22 / 13,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencySymbol = Provider.of<CurrencyProvider>(
      context,
    ).currency.symbol;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final chartHeight = screenHeight * 0.25;
    final dropdownHeight = screenHeight * 0.08;
    final horizontalPadding = screenWidth * 0.04;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF121417),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121417),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Reports',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              fontFamily: 'Inter',
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(54),
            child: Container(
              color: const Color(0xFF121417),
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFF1D2833),
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 3),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white54,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                ),
                tabs: const [
                  Tab(
                    child: SizedBox(
                      height: 53,
                      child: Center(child: Text('Expenses')),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      height: 53,
                      child: Center(child: Text('Income')),
                    ),
                  ),
                  Tab(child: SizedBox(height: 53)), // Optional third tab
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              isExpenseTab: true,
              horizontalPadding: horizontalPadding,
              dropdownHeight: dropdownHeight,
              chartHeight: chartHeight,
              screenHeight: screenHeight,
              currencySymbol: currencySymbol,
            ),
            _buildTabContent(
              isExpenseTab: false,
              horizontalPadding: horizontalPadding,
              dropdownHeight: dropdownHeight,
              chartHeight: chartHeight,
              screenHeight: screenHeight,
              currencySymbol: currencySymbol,
            ),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
