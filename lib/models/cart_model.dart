import 'package:flutter/material.dart';

class Product {
  final String image;
  final String type;
  final String name;
  final double price;

  Product({
    required this.image,
    required this.type,
    required this.name,
    required this.price,
  });
}

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  double get totalPrice => _products.fold(0.0, (total, product) => total + product.price);
}
