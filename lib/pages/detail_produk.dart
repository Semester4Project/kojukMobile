import 'package:flutter/material.dart';

class DetailProduk extends StatelessWidget {
  final Map<String, dynamic> produk;

  const DetailProduk({Key? key, required this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    produk['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 40,
                  child: Column(
                    children: [
                      Text(
                        produk['name'],
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                      'Harga: Rp ${produk['price'].toStringAsFixed(0)}', // Konversi harga menjadi string
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    const Text(
                      "Kopi hitam bubuk kadar kafein yang lebih tinggi dari kopi biasa dengan aroma yang tajam dan rasa pahit yang lebih tinggi. Bagi para coffee adict, kopi hitam bubuk ini sangat cocok untuk menemani disaat menugas dan menikmati sore hari.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                      
                          },
                          icon: Icon(Icons.shopping_cart_checkout),
                          iconSize: 32,
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                          },
                          child: Text(
                            'Beli',
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
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
