import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // Handle shopping cart button press
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.white, // Background color of the profile screen
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/kucing.jpg'),
                  ),
                  Positioned(
                    right: 4,
                    bottom: 4,
                    child: InkWell(
                      onTap: () {
                        // Handle edit profile picture
                      },
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.brown[800], // Match color of icons
                        child: Icon(Icons.edit, size: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Intan Puspitasari',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'intan@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              Divider(color: Colors.brown[800]), // Match color of icons
              ListTile(
                leading: const Icon(Icons.list_alt, color: Colors.brown),
                title: const Text('Daftar Transaksi'),
                onTap: () {
                  // Navigate to transaction list
                },
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                  onPressed: () {
                    // Navigate to transaction list
                  },
                ),
              ),
              Divider(color: Colors.brown[800]), // Match color of icons
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.brown),
                title: const Text('Keranjang'),
                onTap: () {
                  // Navigate to shopping cart
                },
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.brown),
                  onPressed: () {
                    // Navigate to shopping cart
                  },
                ),
              ),
              Divider(color: Colors.brown[800]), // Match color of icons
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.brown),
                title: const Text('Sign Out'),
                onTap: () {
                  // Handle sign out
                },
              ),
              Divider(color: Colors.brown[800]), // Match color of icons
            ],
          ),
        ),
      ),
    );
  }
}
