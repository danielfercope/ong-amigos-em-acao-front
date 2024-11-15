class Item {
  final String id;
  final String name;
  final String GTIN;
  final double wheight;
  final String category;

  const Item({
    required this.id,
    required this.name,
    required this.GTIN,
    required this.wheight,
    required this.category,
  });

// Método para converter JSON em uma instância de Product
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      GTIN: json['GTIN'].toDouble(),
      wheight: json['wheight'].toDouble(),
      category: json['category'].toDouble(),
    );
  }

  // Método para converter uma instância de Product em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'GTIN': GTIN,
      'wheight': wheight,
      'category': category,
    };
  }
}