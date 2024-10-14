import 'package:flutter/material.dart';

class UserTypePage extends StatelessWidget {
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
        title: Text('Quem é você?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Botão Padeiro
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    foregroundColor: Color(0xAA7845),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xAA7845)),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Padeiro',
                    style: TextStyle(
                      color: Color(0xAA7845),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // Botão Caixa
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    foregroundColor: Color(0xAA7845),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xAA7845)),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Caixa',
                    style: TextStyle(
                      color: Color(0xAA7845),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              // Botão Gestor
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    foregroundColor: Color(0xAA7845),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Color(0xAA7845)),
                    ),
                    minimumSize: Size(200, 50),
                  ),
                  child: Text(
                    'Gestor',
                    style: TextStyle(
                      color: Color(0xAA7845),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
