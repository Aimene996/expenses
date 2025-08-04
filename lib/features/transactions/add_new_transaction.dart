import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mactest/features/category/add_category_screen.dart';
import 'package:mactest/features/models/transaction.dart';
import 'package:mactest/features/services/data_service.dart';

class AddNewTransaction extends StatefulWidget {
  final String? selectedCategory;

  const AddNewTransaction({super.key, this.selectedCategory});

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  String selectedType = 'expense';
  String? category;
  DateTime selectedDate = DateTime.now();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    category = widget.selectedCategory;
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF121417),
              surface: Color(0xFF2A2D31),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _openCategorySelector() async {
    final newCategory = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddCategoryScreen()),
    );

    if (newCategory != null) {
      setState(() {
        category = newCategory;
      });
    }
  }

  void _saveTransaction() {
    final String amountText = amountController.text.trim();
    final String note = noteController.text.trim();

    if (amountText.isEmpty || double.tryParse(amountText) == null) {
      print('Invalid amount');
      return;
    }

    final transaction = Transaction(
      type: selectedType,
      category: category ?? 'Uncategorized',
      amount: double.parse(amountText),
      date: selectedDate,
      note: note,
    );

    TransactionHelper.addTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    final textStyleInput = const TextStyle(
      color: Color(0xFF9CA3AF),
      fontSize: 14,
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1D21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1D21),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Transaction',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Type Selector
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D31),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: ['expense', 'income'].map((type) {
                  final isSelected = selectedType == type;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedType = type),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF121417) : null,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            type[0].toUpperCase() + type.substring(1),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Category
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Category', style: textStyleLabel),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _openCategorySelector,
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A2D31),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      category ?? 'Add Category',
                      style: textStyleInput.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Amount
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Amount', style: textStyleLabel),
            ),
            const SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D31),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: amountController,
                style: textStyleInput,
                decoration: const InputDecoration(
                  hintText: r'$0.00',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            const SizedBox(height: 24),

            // Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date', style: textStyleLabel),
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMd().format(selectedDate),
                      style: textStyleInput.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _pickDate,
                      child: const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFF9CA3AF),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Note
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Note', style: textStyleLabel),
            ),
            const SizedBox(height: 12),
            Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2D31),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: noteController,
                style: textStyleInput,
                decoration: const InputDecoration(
                  hintText: 'Add a note',
                  hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE5E7EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Color(0xFF1A1D21),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
