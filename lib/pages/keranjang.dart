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
                      value: cart.products.isNotEmpty &&
                          cart.products.every((product) => cart.isChecked(cart.products.indexOf(product))),
                      onChanged: (bool? value) {
                        for (int i = 0; i < cart.products.length; i++) {
                          if (cart.isChecked(i) != value) {
                            cart.toggleCheckbox(i);
                          }
                        }
                      },
                    ),
                    Text('Semua'),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      },
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
                        product: product,
                        index: index,
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
  final Product product;
  final int index;

  CartItem({
    required this.product,
    required this.index,
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
              product.image,
              width: 40,
              height: 50,
            ),
            SizedBox(width: 3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(product.type),
                Text('Rp ${product.price.toStringAsFixed(0)}'),
              ],
            ),
            Spacer(),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false).increaseQuantity(index);
                  },
                  color: Colors.brown,
                ),
                Text('${product.quantity}'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    Provider.of<CartModel>(context, listen: false).decreaseQuantity(index);
                  },
                  color: Colors.brown,
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).removeProduct(index);
              },
              color: Colors.brown,
            ),
            Checkbox(
              value: Provider.of<CartModel>(context).isChecked(index),
              onChanged: (bool? value) {
                Provider.of<CartModel>(context, listen: false).toggleCheckbox(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
