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

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      GTIN: json['GTIN'],
      wheight: json['wheight'],
      category: json['category'],
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