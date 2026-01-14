
import 'package:flutter/material.dart';
import 'package:redrip/screens/buyer/home_screen.dart';
import 'package:redrip/screens/seller/sell_product_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  const UserSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Wrap with SingleChildScrollView to prevent overflow on small screens
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.recycling, size: 70, color: Colors.green),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to ReDrip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sustainable Fashion Marketplace',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 40),

                // BUY OPTION CARD
                _buildSelectionCard(
                  context,
                  title: 'BUY CLOTHES',
                  subtitle: 'Discover pre-loved fashion',
                  icon: Icons.shopping_bag,
                  color: Colors.green[700]!,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),

                const SizedBox(height: 20),

                // SELL OPTION CARD
                _buildSelectionCard(
                  context,
                  title: 'SELL YOUR CLOTHES',
                  subtitle: 'Give your story a new life',
                  icon: Icons.checkroom,
                  color: Colors.green[400]!,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SellProductScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required Color color,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        // Reduced padding from 35 to 25 to prevent interior overflow
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ],
        ),
        child: Column(
          // Ensure column only takes necessary space
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1)),
            const SizedBox(height: 5),
            Text(subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
