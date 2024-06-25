import 'package:flutter/material.dart';

class EditAlamatPage extends StatefulWidget {
  final Map<String, String>? alamat;

  EditAlamatPage({this.alamat});

  @override
  _EditAlamatPageState createState() => _EditAlamatPageState();
}

class _EditAlamatPageState extends State<EditAlamatPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {
    'nama': '',
    'noHp': '',
    'provinsi': '',
    'kabupaten': '',
    'kecamatan': '',
    'desa': '',
    'kodePos': '',
    'detailAlamat': '',
  };

  @override
  void initState() {
    super.initState();
    if (widget.alamat != null) {
      _formData.addAll(widget.alamat!);
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, _formData);
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
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['nama'],
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['nama'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['noHp'],
                decoration: InputDecoration(labelText: 'Nomor HP'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['noHp'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['provinsi'],
                decoration: InputDecoration(labelText: 'Provinsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provinsi harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['provinsi'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['kabupaten'],
                decoration: InputDecoration(labelText: 'Kabupaten/Kota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kabupaten/Kota harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['kabupaten'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['kecamatan'],
                decoration: InputDecoration(labelText: 'Kecamatan'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kecamatan harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['kecamatan'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['desa'],
                decoration: InputDecoration(labelText: 'Desa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Desa harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['desa'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['kodePos'],
                decoration: InputDecoration(labelText: 'Kode Pos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode Pos harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['kodePos'] = value!;
                },
              ),
              TextFormField(
                initialValue: _formData['detailAlamat'],
                decoration: InputDecoration(labelText: 'Detail Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Detail Alamat harus diisi';
                  }
                  return null;
                },
                onSaved: (value) {
                  _formData['detailAlamat'] = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
