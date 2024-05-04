import 'package:flutter/material.dart';
import 'package:kojuk_mobile/pages/detail_produk.dart';


class Produk  extends StatefulWidget{
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk>{
   // Daftar produk
  TextEditingController _controller = TextEditingController();
  String _searchKeyword = '';
  List<Map<String, dynamic>> products = [
    {
      'image': 'assets/images/kopi.png',
      'type': 'kopi',
      'name': 'kopi Madura',
      'price': 'Rp.5000,00',
    },
    {
      'image': 'assets/images/kopi.png',
      'type': 'Robusta',
      'name': 'Robusta Madura',
      'price': 'Rp.5000,00',
    },
    {
      'image': 'assets/images/kopi.png',
      'type': 'Robusta',
      'name': 'Robusta Madura',
      'price': 'Rp.5000,00',
    },
    {
      'image': 'assets/images/kopi.png',
      'type': 'Robusta',
      'name': 'Robusta jawa',
      'price': 'Rp.5000,00',
    },
    {
      'image': 'assets/images/kopi.png',
      'type': 'Robusta',
      'name': 'Robusta Madura',
      'price': 'Rp.5000,00',
    },
    {
      'image': 'assets/images/kopi.png',
      'type': 'Robusta',
      'name': 'Robusta medan',
      'price': 'Rp.5000,00',
    },
    // Tambahkan produk lainnya sesuai kebutuhan
  ];

  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchResults.addAll(products);
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
        title:const Text('Produk'),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Tambahkan fungsi ketika tombol keranjang ditekan
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize:const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Sesuaikan jaraknya di sini
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Atur tinggi dan lebar rentang
                hintText: 'Search...',
                suffixIcon: GestureDetector(
                  onTap: () {
                    _searchKeyword = _controller.text;
                    _search(_searchKeyword);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 12, 12, 12), // Sesuaikan posisi tombol
                    child: Transform.scale(
                      scale: 1, // Ubah ukuran tombol
                      child:const Icon(
                        Icons.search,
                        color:Color.fromRGBO(146, 37, 35, 1), // Warna ikon pencarian
                      ),
                    ),
                  ),
                ),
                // Atur warna rentang atau garis luarnya
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color.fromRGBO(118, 38, 37, 1)), // Warna saat mendapat fokus
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color:Color.fromRGBO(146, 37, 35, 1)), // Warna saat tidak mendapat fokus
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

      body: GridView.builder(
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
                child: Image.asset(
                  product['image'],
                  width: double.infinity,
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
                      product['price'],
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
)
);
}
}