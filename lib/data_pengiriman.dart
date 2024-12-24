import 'package:flutter/material.dart';

class DataPengiriman extends StatelessWidget {
  const DataPengiriman({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengiriman'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Halaman Data Pengiriman', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
