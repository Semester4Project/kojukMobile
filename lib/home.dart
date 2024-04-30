import 'package:flutter/material.dart';
import 'package:kojuk_mobile/pages/pesanan.dart';
import 'package:kojuk_mobile/pages/produck.dart';
import 'package:kojuk_mobile/pages/dashboard.dart';
import 'package:kojuk_mobile/pages/profile.dart';

class Home extends StatefulWidget{
  
  
  @ override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  int currentTab = 0;
  final List<Widget> screens = [
    Dashboard(),
    Produk(),
    Pesanan(),
    Profile(),
  ];

  final PageStorageBucket bucket= PageStorageBucket();
  Widget currentScreen = Dashboard();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
     bottomNavigationBar: BottomAppBar(
  shape: const CircularNotchedRectangle(),
  notchMargin: 10,
  child: Container(
    height: 60,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Menggunakan spaceAround untuk memberikan jarak yang sama di sekitar setiap ikon
      children: <Widget>[
        Expanded(
          child: MaterialButton(
            onPressed: () {
              setState(() {
                currentScreen = Dashboard();
                currentTab = 0;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  color: currentScreen is Dashboard
                      ? const Color.fromRGBO(118, 38, 37, 1)
                      : Colors.grey,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    color: currentTab == 0
                        ? const Color.fromRGBO(118, 38, 37, 1)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {
              setState(() {
                currentScreen = Produk();
                currentTab = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.coffee,
                  color: currentScreen is Produk
                      ? const Color.fromRGBO(118, 38, 37, 1)
                      : Colors.grey,
                ),
                Text(
                  'Produk',
                  style: TextStyle(
                    color: currentTab == 1
                        ? const Color.fromRGBO(118, 38, 37, 1)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {
              setState(() {
                currentScreen = Pesanan();
                currentTab = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_sharp,
                  color: currentScreen is Pesanan
                      ? const Color.fromRGBO(118, 38, 37, 1)
                      : Colors.grey,
                ),
                Text(
                  'Pesanan',
                  style: TextStyle(
                    color: currentTab == 2
                        ? const Color.fromRGBO(118, 38, 37, 1)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: MaterialButton(
            onPressed: () {
              setState(() {
                currentScreen = Profile();
                currentTab = 3;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  color: currentScreen is Profile
                      ? const Color.fromRGBO(118, 38, 37, 1)
                      : Colors.grey,
                ),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: currentTab == 3
                        ? const Color.fromRGBO(118, 38, 37, 1)
                        : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
       ),
      ),
    );
  }
}