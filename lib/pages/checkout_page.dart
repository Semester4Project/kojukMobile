import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'alamat_page.dart'; // Import halaman Alamat
import 'package:kojuk_mobile/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Map<String, String>? selectedAddress;
  String? selectedPaymentMethod = 'bank'; // Inisialisasi dengan nilai default

  @override
  void initState() {
    super.initState();
    _loadDefaultAddress();
  }

  Future<void> _loadDefaultAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? alamatString = prefs.getString('alamatList');
    if (alamatString != null) {
      List<Map<String, String>> alamatList = List<Map<String, String>>.from(json.decode(alamatString));
      if (alamatList.isNotEmpty) {
        setState(() {
          selectedAddress = alamatList[0]; // Memilih alamat pertama sebagai default
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                final selectedProducts = cart.selectedProducts;
                final selectedTotalPrice = cart.selectedTotalPrice;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          'Alamat Pengiriman',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: selectedAddress != null
                            ? Text(
                                '${selectedAddress!['nama']}\n'
                                '${selectedAddress!['noHp']}\n'
                                '${selectedAddress!['detailAlamat']}\n'
                                '${selectedAddress!['desa']}, ${selectedAddress!['kecamatan']}, '
                                '${selectedAddress!['kabupaten']}, ${selectedAddress!['provinsi']}, '
                                'ID ${selectedAddress!['kodePos']}')
                            : Text('Belum ada alamat yang dipilih.'),
                        trailing: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: () async {
                            // Navigate to address selection page
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AlamatPage(isSelectingAddress: true), // Menggunakan AlamatPage untuk memilih alamat
                              ),
                            );

                            if (result != null && result is Map<String, String>) {
                              setState(() {
                                selectedAddress = result;
                              });
                            }
                          },
                        ),
                      ),
                      Divider(),
                      Text(
                        'Ringkasan Pesanan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: selectedProducts.length,
                        itemBuilder: (context, index) {
                          final product = selectedProducts[index];
                          return ListTile(
                            leading: Image.asset(
                              product.image,
                              width: 40,
                              height: 50,
                            ),
                            title: Text(product.name),
                            subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                            trailing: Text('x${product.quantity}'),
                          );
                        },
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
                              'Rp ${selectedTotalPrice.toStringAsFixed(2)}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      Text(
                        'Metode Pembayaran',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      ListTile(
                        title: const Text('Transfer Bank'),
                        leading: Radio<String>(
                          value: 'bank',
                          groupValue: selectedPaymentMethod,
                          onChanged: (String? value) {
                            setState(() {
                              selectedPaymentMethod = value;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Cash on Delivery'),
                        leading: Radio<String>(
                          value: 'cod',
                          groupValue: selectedPaymentMethod,
                          onChanged: (String? value) {
                            setState(() {
                              selectedPaymentMethod = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 100), // Adding extra space to avoid button overlaying content
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle checkout action
                  if (selectedPaymentMethod == 'bank') {
                    // Show bank transfer details dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Informasi Transfer Bank'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Silahkan transfer ke rekening berikut:'),
                              SizedBox(height: 10),
                              Text('Nomor Rekening: 123456789'),
                              Text('Atas Nama: John Doe'),
                              Text('Bank: Bank ABC'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // Handle COD checkout action
                  }
                },
                icon: Icon(Icons.shopping_cart, color: Colors.white), // Changed icon color to white
                label: Text(
                  'Checkout',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15), // Increased horizontal padding
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
