import 'package:flutter/material.dart';
import 'package:redrip/models/product.dart';

class CartService extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  // Returns the number of items in the cart
  int get itemCount => _items.length;

  void addToCart(Product product) {
    _items.add(product);
    notifyListeners(); // This triggers the UI to update the number on the icon
  }

  void removeFromCart(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.sellingPrice);
  }
}
