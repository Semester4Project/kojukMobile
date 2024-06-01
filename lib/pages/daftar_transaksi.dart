import 'package:flutter/material.dart';

class DaftarTransaksi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Transaksi'),
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TransactionCard(
                    title: 'Kopi Manis',
                    quantity: 1,
                    price: 5000,
                    imageUrl: "assets/images/coffe2.jpg",
                  ),
                  TransactionCard(
                    title: 'Kopi Hitam',
                    quantity: 2,
                    price: 10000,
                    imageUrl: "assets/images/coffe2.jpg",
                  ),
                  TransactionCard(
                    title: 'Kopi Hitam',
                    quantity: 2,
                    price: 10000,
                    imageUrl: "assets/images/coffe2.jpg",
                  ),
                  // Add more TransactionCard widgets here if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String title;
  final int quantity;
  final int price;
  final String imageUrl;

  TransactionCard({
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.brown[700]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              imageUrl,
              width: 50,
              height: 50,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Jumlah Barang: $quantity'),
                  Text('Detail Harga: Rp $price'),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  'Selesai',
                  style: TextStyle(
                    color: Colors.brown[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Pesan Lagi',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
