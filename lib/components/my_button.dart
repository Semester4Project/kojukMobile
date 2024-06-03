import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText; // Properti untuk menentukan teks tombol

  const MyButton({Key? key, required this.onTap, this.buttonText = "Button"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(118, 38, 37, 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            buttonText, // Gunakan properti buttonText untuk menentukan teks tombol
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
