import 'package:flutter/material.dart';
import 'package:panfit_app/screens/production/register/input_register.dart';
import 'package:panfit_app/repository/item_repository.dart';
import 'package:panfit_app/domain/item.dart';

class StockPage extends StatefulWidget {
  const StockPage({Key? key}) : super(key: key);

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  late Future<List<Item>> futureItems;

  @override
  void initState() {
    super.initState();
    futureItems = fetchItems(); // Inicializa a Future para obter os itens
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Produtos'),
              Tab(text: 'Ingredientes'),
            ],
            labelColor: Color(0xFF996536),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF996536),
          ),
        ),
        body: FutureBuilder<List<Item>>(
          future: futureItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar itens: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhum item encontrado'));
            }

            final items = snapshot.data!;

            return TabBarView(
              children: [
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.category),
                    );
                  },
                ),
                Center(child: Text('Lista de Ingredientes')), // Exemplo de outra aba
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navegar para a tela de cadastro de insumos
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputRegisterPage(),
              ),
            );

            // Exibir SnackBar com mensagem de sucesso
            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
            }
          },
          backgroundColor: Color(0xFFF4E9DA),
          child: Icon(Icons.add, color: Color(0xFF996536)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
