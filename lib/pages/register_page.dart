import 'package:flutter/material.dart';
import 'package:kojuk_mobile/components/my_textfield.dart';
import 'package:kojuk_mobile/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void registerUser() {
    // Implement logic to register user here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/logo 2.png",
                  height: 120,
                  width: 205,
                ),
                const SizedBox(height: 2),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'Nama',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: addressController,
                  hintText: 'Alamat',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyButton(
                  buttonText: 'Register',
                  onTap: registerUser,
                ),
                const SizedBox(height: 70),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                  GestureDetector(
              onTap: () {
                // Navigasi ke halaman pendaftaran saat tombol "Register" ditekan
                Navigator.pushNamed(context, '/login');
              },
                   child:const Text(
                      'Login',
                      style: TextStyle(
                        color: Color.fromRGBO(118, 38, 37, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ],
                ),
              ],
          ),
        ),
      ),
      )
    );
  }
}
