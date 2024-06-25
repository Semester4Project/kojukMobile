import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kojuk_mobile/models/cart_model.dart';

class DetailProduk extends StatelessWidget {
  final Map<String, dynamic> produk;

  const DetailProduk({Key? key, required this.produk}) : super(key: key);

  void _tambahkanKeKeranjang(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tambahkan ke Keranjang"),
          content: Text("Apakah Anda ingin menambahkan produk ini ke keranjang?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Tidak
              },
              child: Text("Tidak"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Ya
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value) {
        Provider.of<CartModel>(context, listen: false).addProduct(Product(
          image: produk['image'],
          type: produk['type'],
          name: produk['name'],
          price: produk['price'].toDouble(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          produk['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          produk['name'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis: ${produk['type']}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Harga: Rp ${produk['price'].toStringAsFixed(0)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3), // Space between price and stock
                        Text(
                          'Stok: ${produk['stock']}',
                          style: TextStyle(fontSize: 14, color: Color.fromRGBO(118, 38, 37, 1)),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Detail Produk",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          produk['description'],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Add extra space at the bottom
                ]),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _tambahkanKeKeranjang(context);
                },
                icon: Icon(Icons.shopping_cart, color: Colors.white), // Changed icon color to white
                label: Text(
                  'Tambahkan ke Keranjang',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                  backgroundColor: Color.fromRGBO(118, 38, 37, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
