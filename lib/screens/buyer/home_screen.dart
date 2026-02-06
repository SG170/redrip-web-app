import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Real-time data from Firestore
import 'package:redrip/models/product.dart';
import 'package:redrip/widgets/product_card.dart';
import 'package:redrip/services/cart_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String selectedCategory = 'All';
  List<String> categories = [
    'All',
    'Men',
    'Women',
    'Kids',
    'Formal',
    'Casual',
    'Traditional'
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeView(),
      _buildCategoryView(),
      _buildProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReDrip'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // SearchScreen navigation removed to fix "isn't a class" error
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Search functionality coming soon!")),
              );
            },
          ),
          Consumer<CartService>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      // Navigate to cart logic
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints:
                            const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // --- TAB 1: PRODUCT GRID (Firestore Connected) ---
  Widget _buildHomeView() {
    return Column(
      children: [
        Container(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChoiceChip(
                  label: Text(categories[index]),
                  selected: selectedCategory == categories[index],
                  onSelected: (selected) {
                    setState(() => selectedCategory = categories[index]);
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            // Stream connecting to your real-time inventory
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return const Center(child: Text("Error loading products"));
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Filter products based on selected category chip
              final docs = snapshot.data!.docs.where((doc) {
                if (selectedCategory == 'All') return true;
                return doc['category'] == selectedCategory;
              }).toList();

              if (docs.isEmpty)
                return const Center(child: Text("No products available."));

              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.55,
                ),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  var data = docs[index].data() as Map<String, dynamic>;
                  // Create product object from Firestore data
                  final product = Product(
                    id: docs[index].id,
                    name: data['name'] ?? 'Untitled',
                    description: data['description'] ?? '',
                    originalPrice: (data['originalPrice'] ?? 0).toDouble(),
                    sellingPrice: (data['sellingPrice'] ?? 0).toDouble(),
                    yearsUsed: data['yearsUsed'] ?? 0,
                    category: data['category'] ?? 'Other',
                    condition: data['condition'] ?? 'Good',
                    sellerId: data['seller_id'] ?? '',
                    sellerName: data['seller_name'] ?? 'ReDrip Seller',
                    images: [data['imageUrl'] ?? ''],
                    listedDate: (data['timestamp'] as Timestamp?)?.toDate() ??
                        DateTime.now(),
                    isAvailable: true,
                    size: data['size'] ?? 'M',
                    brand: data['brand'] ?? 'Unknown',
                  );
                  return ProductCard(product: product);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryView() {
    final List<Map<String, dynamic>> categoryItems = const [
      {'name': 'T-Shirts', 'icon': Icons.checkroom},
      {'name': 'Jeans', 'icon': Icons.layers},
      {'name': 'Shoes', 'icon': Icons.directions_run},
      {'name': 'Accessories', 'icon': Icons.watch},
      {'name': 'Jackets', 'icon': Icons.ac_unit},
      {'name': 'Dresses', 'icon': Icons.female},
    ];

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.2,
        ),
        itemCount: categoryItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = categoryItems[index]['name'];
                _selectedIndex = 0;
              });
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
                  Icon(categoryItems[index]['icon'],
                      size: 40, color: Colors.green[700]),
                  const SizedBox(height: 10),
                  Text(categoryItems[index]['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),
          const SizedBox(height: 15),
          const Text("Sustainability Hero",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Text("♻️ Your Recycling Impact",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildImpactStat("12.4kg", "Waste Saved"),
                    _buildImpactStat("8,500L", "Water Saved"),
                  ],
                ),
                const Divider(height: 30),
                const Text(
                    "Your thrifting choices have saved massive amounts of landfill waste!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.green,
                        fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text("Purchase History",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const Card(
            child: ListTile(
              leading: Icon(Icons.history, color: Colors.green),
              title: Text("Vintage Denim Jacket"),
              subtitle: Text("Delivered Jan 10"),
              trailing: Text("₹799"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactStat(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green)),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}

