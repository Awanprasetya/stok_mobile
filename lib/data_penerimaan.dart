import 'package:flutter/material.dart';

class DataPenerimaan extends StatelessWidget {
  const DataPenerimaan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Penerimaan'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Text('Halaman Data Penerimaan', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
