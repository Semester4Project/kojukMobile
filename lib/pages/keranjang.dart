import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kojuk_mobile/models/cart_model.dart';

class Keranjang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total : Rp ${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (bool? value) {},
                    ),
                    Text('Semua'),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'BELI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.products.length,
                    itemBuilder: (context, index) {
                      final product = cart.products[index];
                      return CartItem(
                        imagePath: product.image,
                        title: product.name,
                        description: product.type,
                        price: 'Rp ${product.price.toStringAsFixed(0)}',
                      );
                    },
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

class CartItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final String price;

  CartItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 40,
              height: 50,
            ),
            SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(description),
                Text(price),
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: Colors.brown,
                ),
                Text('1'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {},
                  color: Colors.brown,
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Colors.brown,
            ),
            Checkbox(
              value: false,
              onChanged: (bool? value) {},
            ),
          ],
        ),
      ),
    );
  }
}
