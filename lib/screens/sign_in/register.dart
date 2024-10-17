import 'package:flutter/material.dart';
import 'package:panfit_app/screens/sign_in/login.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/panfit_logo.png',
          height: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Vamos criar sua',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              'Nova Conta',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 120),

            // Campo de E-mail
            Container(
              width: 360,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4E9DA),
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Color(0xFF996536)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF996536),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Senha
            Container(
              width: 360,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4E9DA),
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Color(0xFF996536)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF996536),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Campo de Confirmar senha
            Container(
              width: 360,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4E9DA),
                  labelText: 'Confirmar senha',
                  labelStyle: TextStyle(color: Color(0xFF996536)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Color(0xFF996536),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),

            // Botão de Criar nova conta
            Container(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF996536),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Criar',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 100),

            // Botão de para criar conta/ cadastro de usuário
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Já tenho uma conta',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
