import 'package:flutter/material.dart';
import 'screens/sign_in/login.dart';
import 'screens/sign_in/user_type.dart';
import 'screens/sign_in/register.dart';
import 'screens/user_main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Panfit',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF996536), // Cor do cursor
          selectionColor: Color(0xFFC4A580), // Cor da seleção de texto
          selectionHandleColor: Color(0xFF996536), // Cor das alças de seleção
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/user_type': (context) => UserTypePage(),
        '/register': (context) => RegisterPage(),
        '/main': (context) => UserMainScreen(),
      },
    );
  }
}
