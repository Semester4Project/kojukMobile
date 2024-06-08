import 'package:flutter/material.dart';
import 'package:kojuk_mobile/components/my_textfield.dart';
import 'package:kojuk_mobile/components/my_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  

  void registerUser(BuildContext context) async {
  if (usernameController.text.isEmpty || passwordController.text.isEmpty || emailController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Semua field wajib diisi.',
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
    );
    return;
  }

  try {
    String url = 'http://127.0.0.1:8000/api/auth/register';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
        'email': emailController.text,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Navigator.pushNamed(context, '/login');
    } else {
      var responseBody = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              'Pendaftaran gagal: ${responseBody['message']}', // Tampilkan pesan error dari server
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: Colors.grey,
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
                Image.asset(
                  "assets/images/logo.png",
                  height: 120,
                  width: 205,
                ),
                const SizedBox(height: 20),
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
                 const SizedBox(height: 10),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                 MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 70),
                MyButton(
                 buttonText: 'Register',
                 onTap: () => registerUser(context),
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
