import 'package:flutter/material.dart';
import 'IngredientService.dart';

class IngredientField extends StatefulWidget {
  final int index;
  final Function(int, String, dynamic) onUpdate;

  const IngredientField({required this.index, required this.onUpdate});

  @override
  _IngredientFieldState createState() => _IngredientFieldState();
}

class _IngredientFieldState extends State<IngredientField> {
  List<Map<String, dynamic>> items = [];
  String? selectedId;
  double? quantity;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    try {
      final fetchedItems = await IngredientService.fetchItems();
      setState(() {
        items = fetchedItems;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao carregar itens')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dropdown para selecionar o ingrediente
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            value: selectedId,
            items: items
                .map((item) => DropdownMenuItem<String>(
              value: item['id'] as String,
              child: Text(item['name'] as String),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedId = value!;
                widget.onUpdate(widget.index, 'id', value);
              });
            },
            decoration: InputDecoration(labelText: 'Ingrediente'),
          ),
        ),

        SizedBox(width: 10),

        // Campo de quantidade
        Expanded(
          flex: 1,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Qtd'),
            onChanged: (value) {
              setState(() {
                quantity = double.tryParse(value);
                widget.onUpdate(widget.index, 'wheight', quantity);
              });
            },
          ),
        ),
      ],
    );
  }
}
