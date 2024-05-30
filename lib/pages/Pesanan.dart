import 'package:flutter/material.dart';

class Pesanan extends StatefulWidget {
  @override
  _PesananState createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan'),
        backgroundColor: Colors.brown[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                       "assets/images/coffe2.jpg", 
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Robusta Jawa',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
                Text('Tanggal Pemesanan'),
                Text(
                  '20 - Januari - 2024',
                  style: TextStyle(color: Colors.red),
                ),
                Divider(),
                Text('Total Harga'),
                Text(
                  '5000',
                  style: TextStyle(color: Colors.red),
                ),
                Divider(),
                Text('Status Pemesanan'),
                Text(
                  'Dalam Proses',
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add function to handle button press
                    },
                    child: Text('Pesanan Selesai'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700], // Button color
                      foregroundColor: Colors.white, // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


