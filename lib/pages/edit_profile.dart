import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final File? profileImage;
  final String username;
  final String email;
  final Function(File?, String, String, String, String) onProfileUpdated;

  EditProfile({
    required this.profileImage,
    required this.username,
    required this.email,
    required this.onProfileUpdated,
  });

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _email;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _email = widget.email;
    _image = widget.profileImage;
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (_image != null) {
        await prefs.setString('profile_picture', _image!.path);
      }
      await prefs.setString('username', _username);
      await prefs.setString('email', _email);

      widget.onProfileUpdated(_image, _username, _email, '', '');
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile berhasil diperbarui!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[700],
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: RepaintBoundary(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/images/profile1.jpg') as ImageProvider,
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_library),
                                        title: Text('Gallery'),
                                        onTap: () async {
                                          await _pickImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.photo_camera),
                                        title: Text('Camera'),
                                        onTap: () async {
                                          await _pickImage(ImageSource.camera);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.brown[800],
                            child: Icon(Icons.edit, size: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _username,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan Username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[700],
                ),
                child: const Text(
                  'Simpan Perubahan',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
