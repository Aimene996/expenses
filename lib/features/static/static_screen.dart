import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  // Consistent padding value used throughout the screen
  static const double _horizontalPadding = 16.0;
  static const double _verticalSpacing = 16.0;
  static const double _listItemSpacing = 20.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values
    final chartHeight = screenHeight * 0.25; // 25% of screen height
    final dropdownHeight = screenHeight * 0.08; // 8% of screen height
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width

    return DefaultTabController(
      length: 3, // Three tabs
      child: Scaffold(
        backgroundColor: const Color(0xFF121417),
        appBar: AppBar(
          backgroundColor: const Color(0xFF121417),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                  Tab(child: SizedBox(height: 53)), // Empty tab
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // Expenses Tab - Fully Scrollable
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: _verticalSpacing),

                  // Expense title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Text(
                      "Total Expenses",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Dropdown button
                  Container(
                    height: dropdownHeight.clamp(
                      50.0,
                      80.0,
                    ), // Responsive with min/max
                    width: double.infinity,
                    color: Colors.grey[800],
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Center(
                      child: Text(
                        'Dropdown Placeholder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Place of chart
                  Container(
                    width: double.infinity,
                    color: Colors.green[800],
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expense',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Chart Placeholder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2025',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: _verticalSpacing),
                        Container(
                          height: chartHeight.clamp(
                            180.0,
                            250.0,
                          ), // Responsive with min/max
                          width: double.infinity,
                          color: Colors.blue[800],
                          child: const Center(
                            child: Text(
                              'chart placeholder',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Expenses by Category title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Text(
                      "Expenses By Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Category List
                  Container(
                    width: double.infinity,
                    color: Colors.grey[800],
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Expense',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Chart Placeholder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2025',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: _verticalSpacing),
                        ...List.generate(10, (index) {
                          return Container(
                            margin: EdgeInsets.only(
                              bottom: index == 9
                                  ? 0
                                  : _listItemSpacing, // No margin after last item
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Category ${index + 1}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "\${(index + 1) * 100}",
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),

                  // Extra spacing at bottom for better scrolling
                  SizedBox(height: screenHeight * 0.05), // 5% of screen height
                ],
              ),
            ),

            // Income Tab - Also Scrollable
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: _verticalSpacing),

                  // Income title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Text(
                      "Income View",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Dropdown button
                  Container(
                    height: dropdownHeight.clamp(50.0, 80.0),
                    width: double.infinity,
                    color: Colors.grey[800],
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Center(
                      child: Text(
                        'Income Dropdown Placeholder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Place of chart
                  Container(
                    width: double.infinity,
                    color: Colors.blue[800],
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Income',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Income Chart Placeholder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '2025',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: _verticalSpacing),
                        Container(
                          height: chartHeight.clamp(180.0, 250.0),
                          width: double.infinity,
                          color: Colors.green[800],
                          child: const Center(
                            child: Text(
                              'income chart placeholder',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Income by Category title
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                    child: const Text(
                      "Income By Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),

                  const SizedBox(height: _verticalSpacing),

                  // Income Category List
                  Container(
                    width: double.infinity,
                    color: Colors.grey[800],
                    padding: EdgeInsets.all(horizontalPadding),
                    child: Column(
                      children: List.generate(8, (index) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: index == 7 ? 0 : _listItemSpacing,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Income Source ${index + 1}",
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                "\${(index + 1) * 200}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),

                  // Extra spacing at bottom
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),

            // Empty Tab
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
