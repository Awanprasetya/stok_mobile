import 'package:flutter/material.dart';

class DataStok extends StatelessWidget {
  const DataStok({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Stok'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Halaman Data Stok', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
