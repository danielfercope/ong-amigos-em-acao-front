import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Panfit Caixa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CaixaScreen(),
    );
  }
}

class OrderClass {
  final String imageUrl;
  final String title;
  final String preco;

  OrderClass({
    required this.imageUrl,
    required this.title,
    required this.preco,
  });
}

final List<OrderClass> orders = [
  OrderClass(
    imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitChocolate.png',
    title: 'Bolo de chocolate',
    preco: '52,50',
  ),
  OrderClass(
    imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/boloPanfitMorango.png',
    title: 'Bolo de morango',
    preco: '42,70',
  ),
  OrderClass(
    imageUrl: '/Users/daniel/Projetos/panfit/front/PanfitApp-Front/assets/paoMaromba.png',
    title: 'Pão maromba',
    preco: '35,90',
  ),
];

class CaixaScreen extends StatefulWidget {
  @override
  _CaixaScreenState createState() => _CaixaScreenState();
}

class _CaixaScreenState extends State<CaixaScreen> {
  String selectedPaymentMethod = 'Dinheiro';

  double getTotalPrice() {
    return orders.fold(0, (sum, item) => sum + double.parse(item.preco.replaceAll(',', '.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caixa Panfit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Image.asset(
                        order.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(order.title),
                      subtitle: Text('Preço: R\$ ${order.preco}'),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: R\$ ${getTotalPrice().toStringAsFixed(2).replaceAll('.', ',')}',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedPaymentMethod,
                  items: <String>['Dinheiro', 'Cartão']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica para finalizar o atendimento
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Atendimento Finalizado'),
                      content: Text('Pagamento realizado com $selectedPaymentMethod.\nTotal: R\$ ${getTotalPrice().toStringAsFixed(2).replaceAll('.', ',')}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Finalizar Atendimento'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
