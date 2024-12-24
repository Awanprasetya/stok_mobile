import 'package:alkes_mobile1/dashboard.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Produk',
      home: Dashboard(),
    );
  }
}




