import 'package:flutter/material.dart';
import 'package:kojuk_mobile/models/coffe.dart';

class CoffeTile extends StatelessWidget{
  Coffe coffe;
  CoffeTile({super.key, required this.coffe});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(left: 25),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          //coffe pic
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(coffe.image,
              width: 300, // Adjust width as needed
              height: 330, // Adjust height as needed
              fit: BoxFit.cover,
          
            ),
            
          ),
          //description
          Text(
            coffe.description,
            style: TextStyle(color: Colors.grey[600]),
          ),

          //price +detail
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //coffe name
                    Text(
                      coffe.name, 
                      style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                     ),
                     ),
            
                     const SizedBox(height: 2),
            
                    //price
                    Text(
                      'Rp.' + coffe.price,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      ),
                  ],
                ),
            
                //cart button
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )

          //button to cart
        ],
      ),
    );
  }
}