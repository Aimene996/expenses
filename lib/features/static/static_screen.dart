import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  const SizedBox(height: 15),

                  // Expense title
                  Container(
                    height: 47,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        "Total Expenses ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  // Dropdown button
                  Container(
                    height: 61,
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: const Center(
                      child: Text(
                        'Dropdown Placeholder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Place of chart
                  Container(
                    height: 341,
                    width: double.infinity,
                    color: Colors.green[800],
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          'Chart Placeholder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Expenses by Category title
                  Container(
                    height: 47,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        "Expenses By Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  // Category List - Using Column instead of ListView for scrollability
                  Container(
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: Column(
                      children: List.generate(10, (index) {
                        return ListTile(
                          title: Text(
                            "Category ${index + 1}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Amount: \$${(index + 1) * 100}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Extra spacing at bottom for better scrolling
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Income Tab - Also Scrollable
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),

                  // Income title
                  Container(
                    height: 47,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        "Income View",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  // Dropdown button
                  Container(
                    height: 61,
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: const Center(
                      child: Text(
                        'Income Dropdown Placeholder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Place of chart
                  Container(
                    height: 341,
                    width: double.infinity,
                    color: Colors.blue[800],
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Text(
                          'Income Chart Placeholder',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Income by Category title
                  Container(
                    height: 47,
                    width: double.infinity,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                        bottom: 8,
                      ),
                      child: Text(
                        "Income By Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),

                  // Income Category List
                  Container(
                    width: double.infinity,
                    color: Colors.grey[800],
                    child: Column(
                      children: List.generate(8, (index) {
                        return ListTile(
                          title: Text(
                            "Income Source ${index + 1}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            "Amount: \$${(index + 1) * 200}",
                            style: const TextStyle(color: Colors.white70),
                          ),
                        );
                      }),
                    ),
                  ),

                  // Extra spacing at bottom
                  const SizedBox(height: 20),
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
