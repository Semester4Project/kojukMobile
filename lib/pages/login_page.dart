import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kojuk_mobile/components/my_textfield.dart';
import 'package:kojuk_mobile/components/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // method untuk mengecek dan melakukan proses login
  void signUserIn(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Email atau password wajib diisi.',
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.grey,
        ),
      );
      return;
    }

    try {
      String url = 'http://127.0.0.1:8000/api/auth/login';
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Login gagal. Silakan periksa kembali username dan password Anda.',
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Colors.grey,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'Terjadi kesalahan. Silakan coba lagi.',
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.grey,
        ),
      );
    }
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
                // logo
                Image.asset(
                  "assets/images/logo.png",
                  height: 170,
                  width: 225,
                ),
                const SizedBox(height: 10),

                // welcome back, you've been missed!
                Text(
                  'Login ke akunmu sekarang!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Masukkan Email',
                  obscureText: false,
                ),
                const SizedBox(height: 5),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Masukkan Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman lupa password saat teks "Forgot Password?" ditekan
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color.fromRGBO(118, 38, 37, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  buttonText: 'Login', // Teks tombol login diubah menjadi 'Login'
                  onTap: () => signUserIn(context), // panggil signUserIn dengan context
                ),

                const SizedBox(height: 120),
 
                // or continue with

                // google + apple sign in buttons

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman pendaftaran saat tombol "Register" ditekan
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        'Register',
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
      ),
    );
  }
}
