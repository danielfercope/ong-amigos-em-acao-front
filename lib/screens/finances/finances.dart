import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finances App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FinancesScreen(),
    );
  }
}

class FinancesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            // Colocando a TabBar mais próxima do topo
            Container(
              child: TabBar(
                tabs: [
                  Tab(text: 'Diário'),
                  Tab(text: 'Mensal'),
                  Tab(text: 'Anual'),
                ],
                labelColor: Color(0xFF996536),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF996536),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  DiarioTab(),
                  MensalTab(),
                  AnualTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DiarioTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Total de vendas: 1587,25',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class MensalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Total de vendas: 1587,25',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class AnualTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Total de vendas: 1587,25',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
