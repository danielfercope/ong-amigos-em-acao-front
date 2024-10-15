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
        title: Text(
          'Quem é você?',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Botão Padeiro
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    minimumSize: Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.cookie_outlined,
                        color: Color(0xFFAA7845),
                        size: 70,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Padeiro',
                        style: TextStyle(
                          color: Color(0xFFAA7845),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              // Botão Caixa

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    minimumSize: Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.savings_outlined,
                        color: Color(0xFFAA7845),
                        size: 70,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Caixa',
                        style: TextStyle(
                          color: Color(0xFFAA7845),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Botão Gestor

              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF4E9DA),
                    padding: EdgeInsets.symmetric(vertical: 40),
                    minimumSize: Size(200, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.query_stats_outlined,
                        color: Color(0xFFAA7845),
                        size: 70,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Gestor',
                        style: TextStyle(
                          color: Color(0xFFAA7845),
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
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
