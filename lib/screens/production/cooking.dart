import 'package:flutter/material.dart';

class CookingPage extends StatefulWidget {
  @override
  _CookingPageState createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> {
  final List<Order> orders = [
    Order(
      imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitChocolate.png',
      title: 'Pão Integral',
      priority: 'Alta',
    ),
    Order(
      imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitMorango.png',
      title: 'Bolo de Cenoura',
      priority: 'Média',
    ),
    // Adicione mais ordens aqui
  ];

  // Lista para controlar a seleção de ordens
   List<bool> _selectedOrders = [];

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de seleções com false
    _selectedOrders = List<bool>.filled(orders.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de abas
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 1),
            TabBar(
              tabs: [
                Tab(text: 'Em produção'),
                Tab(text: 'Concluídos'),
              ],
              indicatorColor: Colors.brown, // Personalize a cor do indicador
              labelColor: Colors.black,      // Cor do texto selecionado
              unselectedLabelColor: Colors.grey, // Cor do texto não selecionado
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Aba "Em produção" com a lista de ordens
                  ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final order = orders[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: CheckboxListTile(
                          title: Text(order.title), // Título do produto
                          subtitle: Text('Prioridade: ${order.priority}'), // Prioridade
                          secondary: Image.asset(order.imageUrl), // Imagem do produto
                          value: _selectedOrders[index], // Estado do Checkbox
                          onChanged: (bool? value) {
                            setState(() {
                              _selectedOrders[index] = value!; // Atualiza o estado
                            });
                          },
                        ),
                      );
                    },
                  ),
                  // Aba "Concluídos" - coloque o conteúdo que desejar aqui
                  Center(child: Text('Lista de Itens Concluídos')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe para representar uma ordem (exemplo)
class Order {
  final String imageUrl;
  final String title;
  final String priority;

  Order({
    required this.imageUrl,
    required this.title,
    required this.priority,
  });
}
