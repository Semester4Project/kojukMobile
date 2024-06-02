import 'package:flutter/material.dart';
import 'package:kojuk_mobile/pages/keranjang.dart';
import 'package:kojuk_mobile/pages/daftar_transaksi.dart';
import 'package:kojuk_mobile/pages/edit_profile.dart';
import 'dart:io';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _profileImage;
  String _username = 'Intan Puspitasari';
  String _email = 'intan@gmail.com';
  String _address = 'Jl. Sudirman No. 123';
  String _phoneNumber = '081234567890';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text('Profile'),
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
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/images/kucing.jpg') as ImageProvider,
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              profileImage: _profileImage,
                              username: _username,
                              email: _email,
                              address: _address,
                              phoneNumber: _phoneNumber,
                              onProfileUpdated: (File? image, String username, String email, String address, String phoneNumber) {
                                setState(() {
                                  _profileImage = image;
                                  _username = username;
                                  _email = email;
                                  _address = address;
                                  _phoneNumber = phoneNumber;
                                });
                              },
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.brown[800],
                        child: Icon(Icons.edit, size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                _username,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              Divider(color: Colors.brown[800]),
              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.brown),
                title: const Text('Daftar Transaksi'),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DaftarTransaksi(),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.brown[800]),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.brown),
                title: const Text('Keranjang'),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Keranjang(),
                      ),
                    );
                  },
                ),
              ),
              Divider(color: Colors.brown[800]),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.brown),
                title: const Text('Sign Out'),
                onTap: () {
                  // Handle sign out
                },
              ),
              Divider(color: Colors.brown[800]),
            ],
          ),
        ),
      ),
    );
  }
}
