import 'package:flutter/material.dart';
import 'IngredientField.dart';
import 'IngredientService.dart';

class InputReceipe extends StatefulWidget {
  @override
  _InputReceipeState createState() => _InputReceipeState();
}

class _InputReceipeState extends State<InputReceipe> {
  List<Map<String, dynamic>> ingredients = [];
  int selectedQuantity = 3;
  String selectedCategory = 'receitas de teste';
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeIngredients();
    _categoryController.text = selectedCategory; // Preencher o campo com valor inicial
  }

  void _initializeIngredients() {
    // Inicializa com campos em branco de acordo com a quantidade mínima
    ingredients = List.generate(selectedQuantity, (_) => {'id': null, 'wheight': null});
  }

  void _updateIngredient(int index, String field, dynamic value) {
    setState(() {
      ingredients[index][field] = value;
    });
  }

  Future<void> _submitReceipe() async {
    // Atualizar a categoria com o texto do campo
    selectedCategory = _categoryController.text;

    // Valida se todos os campos estão preenchidos
    if (ingredients.any((ingredient) => ingredient['id'] == null || ingredient['wheight'] == null)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Preencha todos os campos')));
      return;
    }

    final receipe = {
      "category": selectedCategory,
      "items": ingredients,
    };

    try {
      await IngredientService.createReceipe(receipe);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Receita cadastrada com sucesso')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao cadastrar receita')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Receitas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Campo de texto para categoria
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              SizedBox(height: 20),

              // Campo para selecionar quantidade de ingredientes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quantidade de Ingredientes:'),
                  DropdownButton<int>(
                    value: selectedQuantity,
                    items: List.generate(
                      38,
                          (index) => DropdownMenuItem(value: index + 3, child: Text('${index + 3}')),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedQuantity = value!;
                        _initializeIngredients();
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Campos de Ingredientes
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: selectedQuantity,
                itemBuilder: (context, index) {
                  return IngredientField(
                    index: index,
                    onUpdate: _updateIngredient,
                  );
                },
              ),
              SizedBox(height: 20),

              // Botão de salvar receita
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text('Salvar Receita'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.brown, backgroundColor: Colors.white, // Cor do texto e ícone
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Ajustes de padding
                ),
                onPressed: _submitReceipe,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
