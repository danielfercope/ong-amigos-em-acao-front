import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTime extends StatefulWidget {
  @override
  _InputTimeState createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> {
  int quantidade = 1;

  @override
  Widget build(BuildContext context) {
    String dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Insumos',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Color(0xFFAA7845),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Imagem do insumo
            Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 40),

            // Campo Nome
            Container(
              width: 360,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4E9DA),
                  labelText: 'Nome do insumo',
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

            // Campo Quantidade
            Text('Quantidade', style: TextStyle(fontFamily: 'Poppins')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantidade > 1) quantidade--;
                    });
                  },
                ),
                Text(
                  '$quantidade',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantidade++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Campo Status
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Status: Disponível',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 5),

            // Campo Data de cadastro
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Data de cadastro: $dataAtual',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            Spacer(),

            // Botões Salvar e Excluir
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // Botão Excluir insumo
                ElevatedButton.icon(
                  onPressed: () {
                    // Inserir lógica para excluir
                    // habilitar botão apenas quando for editar o insumo
                  },
                  icon: Icon(Icons.delete, color: Colors.white),
                  label: Text(''),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(50, 60),
                  ),
                ),

                // Botão Salvar insumo
                ElevatedButton.icon(
                  onPressed: () {

                    // Ao clicar em "Salvar", exibir mensagem de sucesso e retornar para a tela de estoque
                    Navigator.pop(context, 'Insumo cadastrado com sucesso!');
                  },
                  icon: Icon(Icons.save, color: Colors.black),
                  label: Text('Salvar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFB8FF8A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(120, 60),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
