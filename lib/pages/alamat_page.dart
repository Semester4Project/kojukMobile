import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'edit_alamat_page.dart';

class AlamatPage extends StatefulWidget {
  final bool isSelectingAddress;

  AlamatPage({this.isSelectingAddress = false});

  @override
  _AlamatPageState createState() => _AlamatPageState();
}

class _AlamatPageState extends State<AlamatPage> {
  List<Map<String, String>> alamatList = [];

  @override
  void initState() {
    super.initState();
    _loadAlamat();
  }

  Future<void> _loadAlamat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? alamatString = prefs.getString('alamatList');
    if (alamatString != null) {
      setState(() {
        List<dynamic> jsonData = json.decode(alamatString);
        alamatList = jsonData.map((item) => Map<String, String>.from(item)).toList();
      });
    }
    print('Loaded addresses: $alamatList'); // Debug print
  }

  Future<void> _saveAlamatList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedAlamatList = json.encode(alamatList);
    print('Saving addresses: $encodedAlamatList'); // Debug print
    await prefs.setString('alamatList', encodedAlamatList);
  }

  void _navigateToEditAlamatPage([Map<String, String>? alamat]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditAlamatPage(alamat: alamat),
      ),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        if (alamat == null) {
          alamatList.add(result);
        } else {
          int index = alamatList.indexOf(alamat);
          if (index != -1) {
            alamatList[index] = result;
          }
        }
      });
      await _saveAlamatList(); // Save the updated alamatList to SharedPreferences
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Saya'),
      ),
      body: alamatList.isEmpty
          ? Center(child: Text('Belum ada alamat yang ditambahkan.'))
          : ListView.builder(
              itemCount: alamatList.length,
              itemBuilder: (context, index) {
                final alamat = alamatList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      title: Text(alamat['nama']!, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(alamat['noHp']!),
                          Text(alamat['detailAlamat']!),
                          Text('${alamat['desa']}, ${alamat['kecamatan']}, ${alamat['kabupaten']}, ${alamat['provinsi']}, ID ${alamat['kodePos']}'),
                        ],
                      ),
                      onTap: widget.isSelectingAddress
                          ? () => Navigator.pop(context, alamat)
                          : () => _navigateToEditAlamatPage(alamat),
                      onLongPress: () => _navigateToEditAlamatPage(alamat),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToEditAlamatPage(),
        icon: Icon(Icons.add),
        label: Text('Tambah Alamat Baru'),
      ),
    );
  }
}
