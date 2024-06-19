import 'package:flutter/material.dart';

class EditAlamatPage extends StatefulWidget {
  final Map<String, String>? alamat;

  EditAlamatPage({this.alamat});

  @override
  _EditAlamatPageState createState() => _EditAlamatPageState();
}

class _EditAlamatPageState extends State<EditAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _noHpController;
  late TextEditingController _provinsiController;
  late TextEditingController _kabupatenController;
  late TextEditingController _kecamatanController;
  late TextEditingController _desaController;
  late TextEditingController _detailAlamatController;
  late TextEditingController _kodePosController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.alamat?['nama']);
    _noHpController = TextEditingController(text: widget.alamat?['noHp']);
    _provinsiController = TextEditingController(text: widget.alamat?['provinsi']);
    _kabupatenController = TextEditingController(text: widget.alamat?['kabupaten']);
    _kecamatanController = TextEditingController(text: widget.alamat?['kecamatan']);
    _desaController = TextEditingController(text: widget.alamat?['desa']);
    _detailAlamatController = TextEditingController(text: widget.alamat?['detailAlamat']);
    _kodePosController = TextEditingController(text: widget.alamat?['kodePos']);
  }

  void _simpanAlamat() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'nama': _namaController.text,
        'noHp': _noHpController.text,
        'provinsi': _provinsiController.text,
        'kabupaten': _kabupatenController.text,
        'kecamatan': _kecamatanController.text,
        'desa': _desaController.text,
        'detailAlamat': _detailAlamatController.text,
        'kodePos': _kodePosController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alamat == null ? 'Tambah Alamat' : 'Edit Alamat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(labelText: 'Nama'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _noHpController,
                  decoration: InputDecoration(labelText: 'No HP'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'No HP tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _provinsiController,
                  decoration: InputDecoration(labelText: 'Provinsi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provinsi tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kabupatenController,
                  decoration: InputDecoration(labelText: 'Kabupaten/Kota'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kabupaten/Kota tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kecamatanController,
                  decoration: InputDecoration(labelText: 'Kecamatan'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kecamatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _desaController,
                  decoration: InputDecoration(labelText: 'Desa'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Desa tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _detailAlamatController,
                  decoration: InputDecoration(labelText: 'Detail Alamat Lainnya'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Detail Alamat tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kodePosController,
                  decoration: InputDecoration(labelText: 'Kode Pos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kode Pos tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _simpanAlamat,
                    child: Text('Simpan'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
