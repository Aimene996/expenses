import 'package:flutter/material.dart';
import 'package:mactest/features/settings/widgets/reset_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final List<String> incomeCategories = ['Salary'];
  final List<String> expensesCategories = ['Groceries'];

  String selectedCurrency = 'USD';

  final List<String> currencies = [
    'USD – \$ – US Dollar',
    'EUR – € – Euro',
    'JPY – ¥ – Japanese Yen',
    'GBP – £ – British Pound',
    'AUD – A\$ – Australian Dollar',
    'CAD – C\$ – Canadian Dollar',
    'CHF – Swiss Franc',
    'CNY – ¥ – Chinese Yuan',
    'HKD – HK\$ – Hong Kong Dollar',
    'RUB – ₽ – Russian Ruble',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', textAlign: TextAlign.center),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Currency section
                    Container(
                      width: 390,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Currency',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          DropdownButton<String>(
                            value: selectedCurrency,
                            underline: const SizedBox(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  selectedCurrency = newValue;
                                });
                              }
                            },
                            items: currencies.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value.split(' – ')[0],
                                child: Text(value.split(' – ')[0]),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    // Custom Categories Title
                    Container(
                      width: 390,
                      height: 47,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 16, right: 16, bottom: 8),
                        child: Text(
                          'Custom Categories',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 26, top: 12, bottom: 4),
                      child: Text(
                        'Income',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: incomeCategories
                            .map(
                              (category) =>
                                  _buildCategoryCard(context, category),
                            )
                            .toList(),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Padding(
                      padding: EdgeInsets.only(left: 26, top: 12, bottom: 4),
                      child: Text(
                        'Expenses',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: expensesCategories
                            .map(
                              (category) =>
                                  _buildCategoryCard(context, category),
                            )
                            .toList(),
                      ),
                    ),

                    const Spacer(), // Push reset button to bottom if space allows
                    // ✅ Reset Button at Bottom (dynamically)
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => ConfirmResetDialog(
                          onConfirm: () => Navigator.of(context).pop(),
                          onCancel: () => Navigator.of(context).pop(),
                        ),
                      ),
                      child: Container(
                        width: 358,
                        height: 40,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Theme.of(context).colorScheme.secondary,
                          color: Color(0xFF2B3036),
                        ),
                        child: const Center(
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title) {
    return Container(
      width: 173,
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        // color: Theme.of(context).colorScheme.secondary,
        color: Color(0xFF2B3036),

        // #3B4754
        // border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        children: [
          const Icon(Icons.help_outline, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(Icons.delete, size: 20),
        ],
      ),
    );
  }
}
