import 'package:flutter/material.dart';

class Product {
  final String image;
  final String type;
  final String name;
  final double price;
  int quantity;  // Add quantity field

  Product({
    required this.image,
    required this.type,
    required this.name,
    required this.price,
    this.quantity = 1,  // Default quantity to 1
  });
}

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];
  final List<bool> _checked = [];  // Add checked list to track checkbox states

  List<Product> get products => _products;

  double get totalPrice => _products.fold(0.0, (total, product) => total + product.price * product.quantity);

  void addProduct(Product product) {
    _products.add(product);
    _checked.add(false);  // Add corresponding checkbox state
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    _checked.removeAt(index);  // Remove corresponding checkbox state
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _products[index].quantity += 1;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_products[index].quantity > 1) {
      _products[index].quantity -= 1;
      notifyListeners();
    }
  }

  void toggleCheckbox(int index) {
    _checked[index] = !_checked[index];
    notifyListeners();
  }

  bool isChecked(int index) => _checked[index];
}
