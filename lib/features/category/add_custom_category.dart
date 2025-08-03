import 'package:flutter/material.dart';

class AddCustomCategory extends StatelessWidget {
  const AddCustomCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF121417),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          ' New Category',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.only(top: 319),
                      child: SizedBox(
                        height: 47,
                        width: 390,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            right: 16,
                            left: 16,
                            bottom: 8,
                          ),
                          child: const Text(
                            'Name the custom Categories',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B3036),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Category Name',
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // ✅ Save Button (Responsive at bottom)
                    GestureDetector(
                      onTap: () {
                        // Handle save action
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Container(
                          height: 50,
                          width: 390,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCFDEED),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
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
}
