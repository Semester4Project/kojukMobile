import 'package:flutter/material.dart';
import 'package:kojuk_mobile/components/my_textfield.dart';
import 'package:kojuk_mobile/components/my_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // method untuk mengecek dan melakukan proses login
  void signUserIn(BuildContext context) {
    // periksa apakah kedua field diisi
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      // jika salah satu atau kedua field kosong, tampilkan snackbar sebagai peringatan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
           content: Center(
      child: Text(
        'Username atau password wajib diisi.',
        textAlign: TextAlign.center,
      ),
    ),
    backgroundColor: Colors.grey,
        ),
      );
    } else {
      // jika kedua field sudah diisi, lakukan proses login
      // Anda dapat menambahkan logika login sesuai dengan kebutuhan Anda di sini

      // contoh: navigasi ke halaman dashboard setelah login berhasil
      Navigator.pushNamed(context, '/home');
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
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 5),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),

                // forgot password?
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Color.fromRGBO(118, 38, 37, 1)),
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
