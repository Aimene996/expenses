import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive values while maintaining original proportions
    final horizontalPadding = screenWidth * 0.04; // 4% of screen width
    final cardWidth =
        (screenWidth - (horizontalPadding * 3)) / 2; // Responsive card width
    final savingsCardWidth =
        screenWidth - (horizontalPadding * 2); // Full width minus padding

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Main content with bottom padding to avoid FAB overlap
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(bottom: 100), // Space for fixed button
              child: Column(
                children: [
                  // Overview Header
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 12,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: const Text(
                        'Overview ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'inter',
                        ),
                      ),
                    ),
                  ),

                  // Overview Section
                  Container(
                    height: 268,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatCard(
                              '\$12,500',
                              'Income',
                              context,
                              cardWidth,
                            ),
                            _buildStatCard(
                              '\$8,750',
                              'Expenses',
                              context,
                              cardWidth,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: savingsCardWidth.clamp(
                            300.0,
                            400.0,
                          ), // Responsive with limits
                          height: 110,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Color(0xFF293038),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Savings',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '\$8,750',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Latest Header
                  Container(
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 12,
                        left: horizontalPadding,
                        right: horizontalPadding,
                      ),
                      child: const Text(
                        'Latest ',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Latest Flow Items
                  _buildTransactionRow(
                    'Freelance',
                    'UI Design',
                    '\$240.00',
                    Icons.design_services,
                    context,
                    horizontalPadding,
                  ),
                  _buildTransactionRow(
                    'Groceries',
                    'Supermarket',
                    '\$85.50',
                    Icons.shopping_cart,
                    context,
                    horizontalPadding,
                  ),
                  _buildTransactionRow(
                    'Subscription',
                    'Netflix',
                    '\$15.99',
                    Icons.subscriptions,
                    context,
                    horizontalPadding,
                  ),
                  _buildTransactionRow(
                    'Utilities',
                    'Electricity Bill',
                    '\$120.00',
                    Icons.bolt,
                    context,
                    horizontalPadding,
                  ),
                ],
              ),
            ),
          ),

          // Fixed Add Button at Bottom
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 112,
                height: 56,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // Add action here
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
                  elevation: 8, // Added elevation for better visibility
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Stat Card - Now responsive
  Widget _buildStatCard(
    String title,
    String value,
    BuildContext context,
    double cardWidth,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: cardWidth.clamp(150.0, 200.0), // Responsive with min/max limits
      height: 110,
      decoration: BoxDecoration(
        color: Color(0xFF293038),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Transaction Row - Now responsive
  Widget _buildTransactionRow(
    String title,
    String subtitle,
    String price,
    IconData icon,
    BuildContext context,
    double horizontalPadding,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: 72,
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon + Text
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFF293038),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: theme.iconTheme.color),
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
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9EABBA),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
