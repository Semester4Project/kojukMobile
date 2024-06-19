import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kojuk_mobile/pages/alamat_page.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'keranjang.dart';
import 'daftar_transaksi.dart';
import 'edit_profile.dart';
import 'login_page.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _profileImage;
  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'No Name';
      _email = prefs.getString('email') ?? 'No Email';
      String? profileImagePath = prefs.getString('profile_picture');
      if (profileImagePath != null && profileImagePath.isNotEmpty) {
        _profileImage = File(profileImagePath);
      }
    });
  }

  Future<void> logout(BuildContext context) async {
    final url = 'http://127.0.0.1:8000/api/auth/logout';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_TOKEN_HERE',  // Sesuaikan token jika dibutuhkan
      },
    );

    if (response.statusCode == 200) {
      // Hapus data pengguna dari SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      Navigator.of(context).pushReplacementNamed('/login');
    } else {
      final errorResponse = json.decode(response.body);
      print('Logout failed: ${errorResponse['message']}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Logout Failed'),
          content: Text(errorResponse['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
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
        child: SingleChildScrollView(
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
                          : AssetImage('assets/images/profile1.jpg') as ImageProvider,
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
                                onProfileUpdated: (File? image, String username, String email, String _, String __) async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  setState(() {
                                    _profileImage = image;
                                    _username = username;
                                    _email = email;
                                  });
                                  if (image != null) {
                                    await prefs.setString('profile_picture', image.path);
                                  }
                                  await prefs.setString('username', username);
                                  await prefs.setString('email', email);
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
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _email,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
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
                  leading: const Icon(Icons.location_on, color: Colors.brown),
                  title: const Text('Alamat'),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                    onPressed: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlamatPage(),
                        ),
                      );*/// Navigate to address management screen (to be implemented)
                    },
                  ),
                ),
                Divider(color: Colors.brown[800]),
                ListTile(
                  leading: const Icon(Icons.exit_to_app, color: Colors.brown),
                  title: const Text('Sign Out'),
                  onTap: () {
                    logout(context);
                  },
                ),
                Divider(color: Colors.brown[800]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
