import 'package:dio/dio.dart';
import 'package:panfit_app/domain/item.dart';

Future<List<Item>> fetchItems() async {
  try {
    var dio = Dio();
    final response = await dio.get('http://localhost:8083/item');

    if (response.statusCode == 200) {
      return (response.data as List).map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao carregar itens');
    }
  } catch (e) {
    print('Erro: $e');
    throw Exception('Erro na solicitação $e');
  }
}
