import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanProduk extends StatefulWidget {
  const HalamanProduk({super.key});

  @override
  State<HalamanProduk> createState() => _HalamanProdukState();
}

class _HalamanProdukState extends State<HalamanProduk> {
  List _listdata = [];
  bool _loading = true;

  // Fungsi untuk mendapatkan data produk
  Future<void> _getdata() async {
    try {
      final respon = await http.get(Uri.parse('http://192.168.1.35/api_produk/read.php'));
      if (respon.statusCode == 200) {
        print(respon.body); // Tambahkan ini untuk debugging
        final List data = jsonDecode(respon.body); // Pastikan ini berupa List
        setState(() {
          _listdata = data;
          _loading = false;
        });
      } else {
        print('Gagal mendapatkan data: ${respon.statusCode}');
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  // Fungsi untuk menambah produk
  Future<void> _createProduct(String kdProduk,String nmProduk, String jenisProduk, String packProduk, String boxProduk) async {
    try {
      final url = Uri.parse('http://192.168.1.35/api_produk/create.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kd_produk': kdProduk,
          'nm_produk': nmProduk,
          'jenis': jenisProduk,
          'pack': packProduk,
          'box': boxProduk,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result['message']);
        _getdata(); // Refresh data setelah produk berhasil dibuat
      } else {
        print('Gagal menambahkan produk: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fungsi untuk mengupdate produk
  Future<void> _updateProduct(String kdProduk, String nmProduk, String jenisProduk, String packProduk, String boxProduk) async {
    try {
      final url = Uri.parse('http://192.168.1.35/api_produk/update.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kd_produk': kdProduk,
          'nm_produk': nmProduk,
          'jenis': jenisProduk,
          'pack': packProduk,
          'box': boxProduk,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result['message']);
        _getdata(); // Refresh data setelah produk berhasil diupdate
      } else {
        print('Gagal mengupdate produk: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fungsi untuk menghapus produk
  Future<void> _deleteProduct(String kdProduk) async {
    try {
      final url = Uri.parse('http://192.168.1.35/api_produk/delete.php');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'kd_produk': kdProduk,
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(result['message']);
        _getdata(); // Refresh data setelah produk berhasil dihapus
      } else {
        print('Gagal menghapus produk: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  // Dialog untuk menambah produk
  void _showCreateDialog() {
    final TextEditingController kdController = TextEditingController();
    final TextEditingController nmController = TextEditingController();
    final TextEditingController jenisController = TextEditingController();
    final TextEditingController packController = TextEditingController();
    final TextEditingController boxController = TextEditingController();

// List pilihan jenis produk
  List<String> jenisProdukList = ['BLOOD TUBE', 'DESINFECTANT', 'VTM', 'LAINNYA'];
  String? selectedJenisProduk; // Untuk menyimpan pilihan yang dipilih
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Produk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: kdController,
                decoration: InputDecoration(labelText: 'Kode Produk'),
              ),
              TextField(
                controller: nmController,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              // Mengubah TextField menjadi DropdownButtonFormField
            DropdownButtonFormField<String>(
              value: selectedJenisProduk, // Nilai yang dipilih
              decoration: InputDecoration(labelText: 'Jenis Produk'),
              items: jenisProdukList.map((String jenis) {
                return DropdownMenuItem<String>(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedJenisProduk = newValue; // Mengubah nilai yang dipilih
                });
              },
              hint: Text('Pilih Jenis Produk'),
            ),
              TextField(
                controller: packController,
                decoration: InputDecoration(labelText: 'Pack Produk'),
              ),
              TextField(
                controller: boxController,
                decoration: InputDecoration(labelText: 'Box Produk'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _createProduct(
                  kdController.text,
                  nmController.text,
                  jenisController.text,
                  packController.text,
                  boxController.text,
                );
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk mengedit produk
 void _showEditDialog(String kdProduk, String nmProduk, String jenisProduk, String packProduk, String boxProduk) {
  final TextEditingController nmController = TextEditingController(text: nmProduk);
  final TextEditingController packController = TextEditingController(text: packProduk);
  final TextEditingController boxController = TextEditingController(text: boxProduk);

  // Daftar pilihan jenis produk
  List<String> jenisProdukList = ['BLOOD TUBE', 'DESINFECTANT', 'VTM', 'LAINNYA'];
  
  // Menyimpan jenis produk yang dipilih sebelumnya
  String? selectedJenisProduk = jenisProduk; // Menggunakan nilai jenisProduk yang sudah ada

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nmController,
              decoration: InputDecoration(labelText: 'Nama Produk'),
            ),
            // DropdownButtonFormField yang menampilkan jenis produk yang dipilih sebelumnya
            DropdownButtonFormField<String>(
              value: selectedJenisProduk, // Menampilkan jenis yang dipilih sebelumnya
              decoration: InputDecoration(labelText: 'Jenis Produk'),
              items: jenisProdukList.map((String jenis) {
                return DropdownMenuItem<String>(
                  value: jenis,
                  child: Text(jenis),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedJenisProduk = newValue; // Mengubah nilai yang dipilih
                });
              },
              hint: Text('Pilih Jenis Produk'),
            ),
            TextField(
              controller: packController,
              decoration: InputDecoration(labelText: 'Pack Produk'),
            ),
            TextField(
              controller: boxController,
              decoration: InputDecoration(labelText: 'Box Produk'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _updateProduct(
                kdProduk,
                nmController.text,
                selectedJenisProduk ?? jenisProduk, // Menggunakan selectedJenisProduk jika sudah dipilih, jika tidak, tetap menggunakan jenisProduk yang lama
                packController.text,
                boxController.text,
              );
            },
            child: Text('Simpan'),
          ),
        ],
      );
    },
  );
}


  // Dialog untuk menghapus produk
  void _showDeleteDialog(String kdProduk) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Hapus Produk'),
          content: Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteProduct(kdProduk);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk menampilkan detail produk
  void _showDetailDialog(String nmProduk, String jenisProduk, String packProduk, String boxProduk) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detail Produk'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nama Produk: $nmProduk'),
              Text('Jenis Produk: $jenisProduk'),
              Text('Pack Produk: $packProduk'),
              Text('Box Produk: $boxProduk'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Tampilan Utama
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Produk'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      '${_listdata[index]['nm_produk']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make title bold
                      ),
                    ),
                    subtitle: Text('Jenis: ${_listdata[index]['jenis']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditDialog(
                              _listdata[index]['kd_produk'],
                              _listdata[index]['nm_produk'],
                              _listdata[index]['jenis'],
                              _listdata[index]['pack'],
                              _listdata[index]['box'],
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteDialog(_listdata[index]['kd_produk']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            _showDetailDialog(
                              _listdata[index]['nm_produk'],
                              _listdata[index]['jenis'],
                              _listdata[index]['pack'],
                              _listdata[index]['box'],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepOrange,
      ),
    );
  }
}
