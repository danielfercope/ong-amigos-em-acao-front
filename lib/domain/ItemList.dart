import 'item.dart';

class ItemList {
  final List<Item> items;

  ItemList({required this.items});

  factory ItemList.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>;
    List<Item> items = list.map((i) => Item.fromJson(i)).toList();
    return ItemList(items: items);
  }
}
