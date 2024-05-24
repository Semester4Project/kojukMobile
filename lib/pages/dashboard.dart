import 'package:flutter/material.dart';
import 'package:kojuk_mobile/components/coffe_tile.dart';
import 'package:kojuk_mobile/models/coffe.dart';
import 'package:kojuk_mobile/pages/keranjang.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Keranjang(),
                ),
              ); // Tambahkan fungsi ketika tombol keranjang ditekan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'search',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            // Message
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
              child: Text(
                'everyone flies.. some fly longer than others',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            // Hot picks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Hot Picks 🔥',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 470, // Adjust the height as needed
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // Create coffee
                  Coffe coffee = Coffe(
                    name: 'Robusta jawa',
                    price: '500000',
                    image: 'assets/images/coffe2.jpg',
                    type: 'Robusta',
                  );
                  return CoffeTile(coffe: coffee);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 25, right: 25),
              child: Divider(
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
