import 'package:flutter/material.dart';

class Produk  extends StatefulWidget{
  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Produk')),
      body: Center(
        child:Text('Produk Screen', style: TextStyle(fontSize: 40))),

    );
  }
}