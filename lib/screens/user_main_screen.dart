import 'package:flutter/material.dart';
import 'production/orders.dart';
import 'production/cooking.dart';
import 'production/stock.dart';
import 'package:panfit_app/components/side_bar.dart';

class UserMainScreen extends StatefulWidget {
  @override
  _UserMainScreenState createState() => _UserMainScreenState();
}

class _UserMainScreenState extends State<UserMainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
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
            icon: Icon(Icons.shopping_cart),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_food_beverage_outlined),
            label: 'Produção',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Estoque',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF996536),
        onTap: _onItemTapped,
      ),
    );
  }
}
