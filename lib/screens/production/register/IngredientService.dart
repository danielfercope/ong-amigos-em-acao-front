import 'dart:convert';
import 'package:http/http.dart' as http;

class IngredientService {
  static const String baseUrl = 'http://localhost:8083';

  static Future<List<Map<String, dynamic>>> fetchItems() async {
    final response = await http.get(Uri.parse('$baseUrl/item'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((item) => {
        'id': item['id'],
        'name': item['name'],
      }).toList();
    } else {
      throw Exception('Erro ao carregar itens');
    }
  }

  static Future<void> createReceipe(Map<String, dynamic> receipe) async {
    final response = await http.post(
      Uri.parse('$baseUrl/receipe'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(receipe),
    );


  }
}
