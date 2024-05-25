import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kojuk_mobile/home.dart';
import 'package:kojuk_mobile/pages/keranjang.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'models/cart_model.dart'; // Import file yang berisi definisi CartModel
import 'pages/checkout_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Tambahkan penyedia di sini
      create: (context) => CartModel(), // Buat instance CartModel
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/register': (context) => RegisterPage(),
          '/home':(context) => Home(),
          '/keranjang':(context) => Keranjang(),
          '/checkout': (context) => CheckoutPage(),
        },
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) {
              return const Scaffold(
                body: Center(
                  child: Text('Halaman tidak ditemukan'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
