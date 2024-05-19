import 'package:flutter/material.dart';
import 'package:kojuk_mobile/models/coffe.dart';

class CoffeTile extends StatelessWidget {
  final Coffe coffe;
  CoffeTile({Key? key, required this.coffe});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle navigation to coffee detail page here
        
      },
      child: Container(
        margin: EdgeInsets.only(left: 25, top: 10, bottom: 10),
        width: 280,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Coffee picture
            Flexible(
              flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.asset(
                  coffe.image,
                  fit: BoxFit.cover, // Fit the image within the container
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    coffe.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  // Coffee name
                  Text(
                    coffe.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Price and cart button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp.' + coffe.price,
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
