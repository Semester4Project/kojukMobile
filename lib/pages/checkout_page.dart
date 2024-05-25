import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kojuk_mobile/models/cart_model.dart';

class CheckoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ringkasan Pesanan',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final product = cart.products[index];
                      return ListTile(
                        leading: Image.asset(
                          product.image,
                          width: 40,
                          height: 50,
                        ),
                        title: Text(product.name),
                        subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                        trailing: Text('x${product.quantity}'), // Display the correct quantity
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Harga',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Alamat Pengiriman',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Masukkan Alamat Pengiriman',
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                Text(
                  'Metode Pembayaran',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ListTile(
                  title: const Text('Transfer Bank'),
                  leading: Radio(
                    value: 'bank',
                    groupValue: 'payment',
                    onChanged: (String? value) {
                      // Handle the payment method change
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Cash on Delivery'),
                  leading: Radio(
                    value: 'cod',
                    groupValue: 'payment',
                    onChanged: (String? value) {
                      // Handle the payment method change
                    },
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle checkout action
                    },
                    child: Text('Beli Sekarang'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.grey, // Warna tombol
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
