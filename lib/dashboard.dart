import 'package:flutter/material.dart';
import 'halaman_produk.dart'; // Halaman Data Barang
import 'data_stok.dart';   // Halaman Data Stok
import 'data_pengiriman.dart'; // Halaman Data Pengiriman
import 'data_penerimaan.dart'; // Halaman Data Penerimaan

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: const Color.fromARGB(255, 17, 107, 217),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // Menampilkan 2 kolom
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            _buildMenuCard(context, 'Data Produk', Icons.shopping_bag, HalamanProduk()),
            _buildMenuCard(context, 'Data Stok', Icons.inventory, DataStok()),
            _buildMenuCard(context, 'Data Pengiriman', Icons.local_shipping, DataPengiriman()),
            _buildMenuCard(context, 'Data Penerimaan', Icons.archive, DataPenerimaan()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      color: Colors.orange[100],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.deepOrange),
              SizedBox(height: 10),
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
