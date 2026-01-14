import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = const [
    {'name': 'T-Shirts', 'icon': Icons.checkroom},
    {'name': 'Jeans', 'icon': Icons.layers},
    {'name': 'Shoes', 'icon': Icons.directions_run},
    {'name': 'Accessories', 'icon': Icons.watch},
    {'name': 'Jackets', 'icon': Icons.ac_unit},
    {'name': 'Dresses', 'icon': Icons.female},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Future: Filter HomeScreen by this category
              },
              child: Card(
                color: Colors.green[50],
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(color: Colors.green[100]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(categories[index]['icon'],
                        size: 40, color: Colors.green[700]),
                    const SizedBox(height: 10),
                    Text(
                      categories[index]['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
