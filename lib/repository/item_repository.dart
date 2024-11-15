import 'package:dio/dio.dart';
import 'package:panfit_app/domain/item.dart';

import '../domain/ItemList.dart';

Future<List<Item>> fetchItems() async {
  try {
    var dio = Dio();
    final response = await dio.get('http://localhost:8083/item');

    if (response.statusCode == 200) {
      var jsonData = response.data;
      if (jsonData != null && jsonData['data'] != null) {
        ItemList itemList = ItemList.fromJson(jsonData);
        return itemList.items;
      } else {
        throw Exception('Estrutura de resposta inválida');
      }
    } else {
      throw Exception('Falha ao carregar itens');
    }
  } catch (e) {
    print('Erro: $e');
    throw Exception('Erro na solicitação $e');
  }
}
