import 'package:flutter/material.dart';
import 'package:panfit_app/screens/production/register/input_time.dart';
import '../util/OrderClass.dart';

<<<<<<< HEAD
//GET http://localhost:8083/production?is_completed=false
=======
>>>>>>> 14b18273c10bd8cca23e1b7451ec833ecdf06a12
class OrdersPage extends StatelessWidget {
  final List<OrderClass> orders = [
    OrderClass(
      imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitChocolate.png',
      title: 'Bolo de chocolate',
      priority: 'Alta',
    ),
    OrderClass(
      imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitMorango.png',
      title: 'Bolo de morango',
      priority: 'Média',
    ),
    OrderClass(
      imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/paoMaromba.png',
      title: 'Pão maromba',
      priority: 'Baixa',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''
            'Pedidos de Produção',
        style: TextStyle(
          color: Colors.brown,
          fontFamily: 'Poppins',
        ),
        ),

      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(order.imageUrl), // Imagem do produto
              title: Text(order.title), // Título do produto
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Prioridade: ${order.priority}'), // Prioridade
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriorityIcon(order.priority),   // Ícone de prioridade`
                    ],
                  ),
                ],
              ),

              trailing: ElevatedButton(
                  onPressed: () async {

                    // Ao clicar no botão Add, abrir a tela de cadastro de insumos
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputTime(order: order,),
                      ),
                    );

                    // Exibir o SnackBar com a mensagem de sucesso ao retornar para a tela de estoque
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    }
                  },
                child: Text('Iniciar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC4A580),
                  foregroundColor: Colors.white,// Cor de fundo do botão
                ),
              ), // Botão "Iniciar" no trailing
              // Ícone de prioridade
            ),
          );
        },
      ),
    );
  }


  Widget _buildPriorityIcon(String priority) {
    switch (priority) {
      case 'Alta':
        return Icon(Icons.campaign_sharp, color: Colors.red);
      case 'Média':
        return Icon(Icons.warning, color: Colors.orange);
      case 'Baixa':
        return Icon(Icons.watch_later_outlined, color: Colors.blueGrey);
      default:
        return Icon(Icons.help_outline);
    }
  }
}



