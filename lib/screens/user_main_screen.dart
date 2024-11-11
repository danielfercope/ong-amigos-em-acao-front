import 'package:flutter/material.dart';
import 'production/orders.dart';
import 'production/cooking.dart';
import 'production/stock.dart';
import 'finances/finances.dart';
import 'finances/caixaScreen.dart';
import 'package:panfit_app/components/side_bar.dart';

class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    CaixaScreen(),
    FinancesScreen(),
    OrdersPage(),
    CookingPage(),
    StockPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/panfitLogo.png',
          height: 40,
        ),
      ),
      drawer: SideBar(),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Caixa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Faturamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Produção',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse),
            label: 'Estoque',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF996536),
        unselectedItemColor: Colors.grey, // Cor dos itens não selecionados
        onTap: _onItemTapped,
      ),
    );
  }
}
