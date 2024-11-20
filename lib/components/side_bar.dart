import 'package:flutter/material.dart';
import 'package:panfit_app/screens/sign_in/login.dart';

import '../screens/production/register/input_receipe.dart';
import '../screens/production/register/input_register.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF996536),
            ),
            child: Text(
              'Panfit Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Página inicial'),
            onTap: () {
              Navigator.pop(context);
              // Informar arquivo dart para direcionar usuário
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_stories),
            title: Text('Cadastro de receitas'),
            onTap: () async {
              // Navegar para a tela de cadastro de insumos
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InputReceipe(),
                ),
              );

              // Exibir SnackBar com mensagem de sucesso
              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Cadastro de categorias'),
            onTap: () {
              Navigator.pop(context);
              // Informar arquivo dart para direcionar usuário
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Informar arquivo dart para direcionar usuário
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('Suporte'),
            onTap: () {
              Navigator.pop(context);
              // Informar arquivo dart para direcionar usuário
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
