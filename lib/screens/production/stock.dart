import 'package:flutter/material.dart';
import 'package:panfit_app/screens/production/register/input_register.dart';

class StockPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Produtos'),
                Tab(text: 'Ingredientes'),
              ],
              labelColor: Color(0xFF996536),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF996536),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: Text('Lista de Produtos'),
                  ),
                  Center(
                    child: Text('Lista de Ingredientes'),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {

            // Ao clicar no botão Add, abrir a tela de cadastro de insumos
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputRegisterPage(),
              ),
            );

            // Exibir o SnackBar com a mensagem de sucesso ao retornar para a tela de estoque
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
