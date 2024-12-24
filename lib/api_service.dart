import 'dart:convert';
import 'package:http/http.dart' as http;
import 'item.dart';

class ApiService {
  static const String baseUrl = "http://192.168.1.35/api.php";

 Future<List<Item>> getItems() async {
 final response = await http.get(Uri.parse('$baseUrl?action=get_items'));


  if (response.statusCode == 200) {
    // Jika server mengembalikan respons yang valid
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => Item.fromJson(item)).toList();
  } else {
    // Jika terjadi kesalahan
    throw Exception('Gagal memuat data, status code: ${response.statusCode}');
  }
}

  Future<void> addItem(String name, int quantity, double price) async {
    await http.post(
      Uri.parse("$baseUrl?action=add_item"),
      body: {'name': name, 'quantity': quantity.toString(), 'price': price.toString()},
    );
  }

  Future<void> deleteItem(int id) async {
    await http.post(
      Uri.parse("$baseUrl?action=delete_item"),
      body: {'id': id.toString()},
    );
  }
}
