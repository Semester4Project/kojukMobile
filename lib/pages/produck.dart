import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kojuk_mobile/pages/detail_produk.dart';
import 'package:kojuk_mobile/pages/keranjang.dart';

class Produk extends StatefulWidget {
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  TextEditingController _controller = TextEditingController();
  String _searchKeyword = '';
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/products-and-categories'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        setState(() {
          products = (data['products'] as List).map((product) {
            return {
              'id': product['id_product'],
              'image': product['foto'],
              'type': product['category']['name'],
              'name': product['nama_produk'],
              'price': product['harga'],
              'description': product['deskripsi'],
              'stock': product['berat'], // Assuming 'berat' as stock for example
            };
          }).toList();
          _searchResults.addAll(products);
          isLoading = false;
        });
      }
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  void _search(String keyword) {
    setState(() {
      _searchResults = products.where((product) => product['name'].toLowerCase().contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produk'),
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Keranjang(),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                hintText: 'Search...',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _searchKeyword = _controller.text;
                    _search(_searchKeyword);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                    child: Transform.scale(
                      scale: 1,
                      child: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(146, 37, 35, 1),
                      ),
                    ),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(118, 38, 37, 1)),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(146, 37, 35, 1)),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                  _search(_searchKeyword);
                });
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProduk(produk: product),
                      ),
                    );
                  },
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  product['type'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(product['name']),
                                SizedBox(height: 4),
                                Text(
                                  'Harga: Rp ${product['price'].toStringAsFixed(0)}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
