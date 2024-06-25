import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() => {
        'image': image,
        'type': type,
        'name': name,
        'price': price,
        'quantity': quantity,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        image: json['image'],
        type: json['type'],
        name: json['name'],
        price: json['price'],
        quantity: json['quantity'],
      );
}

class CartModel extends ChangeNotifier {
  final List<Product> _products = [];
  final List<bool> _checked = [];

  CartModel() {
    _loadCart();
  }

  List<Product> get products => _products;
  List<Product> get selectedProducts => _products.where((product) => isChecked(_products.indexOf(product))).toList();

  double get totalPrice => _products.fold(0.0, (total, product) => total + product.price * product.quantity);
  double get selectedTotalPrice => selectedProducts.fold(0.0, (total, product) => total + product.price * product.quantity);

  void addProduct(Product product) {
    _products.add(product);
    _checked.add(false);
    _saveCart();
    notifyListeners();
  }

  void removeProduct(int index) {
    _products.removeAt(index);
    _checked.removeAt(index);
    _saveCart();
    notifyListeners();
  }

  void increaseQuantity(int index) {
    _products[index].quantity += 1;
    _saveCart();
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_products[index].quantity > 1) {
      _products[index].quantity -= 1;
      _saveCart();
      notifyListeners();
    }
  }

  void toggleCheckbox(int index) {
    _checked[index] = !_checked[index];
    _saveCart();
    notifyListeners();
  }

  bool isChecked(int index) => _checked[index];

  Future<void> _saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> products = _products.map((product) => json.encode(product.toJson())).toList();
    List<String> checked = _checked.map((check) => check.toString()).toList();
    await prefs.setStringList('cartProducts', products);
    await prefs.setStringList('cartChecked', checked);
  }

  Future<void> _loadCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? products = prefs.getStringList('cartProducts');
    List<String>? checked = prefs.getStringList('cartChecked');

    if (products != null && checked != null) {
      _products.clear();
      _checked.clear();
      _products.addAll(products.map((product) => Product.fromJson(json.decode(product))).toList());
      _checked.addAll(checked.map((check) => check == 'true').toList());
      notifyListeners();
    }
  }
}
