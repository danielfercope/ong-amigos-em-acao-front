import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class InputTime extends StatefulWidget {
  @override
  _InputTimeState createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> with SingleTickerProviderStateMixin {
  int quantidade = 1;
  int durationInSeconds = 0; // Duração do temporizador em segundos
  bool isRunning = false; // Indica se o temporizador está em execução
  late AnimationController _controller; // Controlador de animação
  late Animation<double> _animation; // Animação de contagem regressiva

  @override
  void initState() {
    super.initState();
    // Inicializa o controlador de animação
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: durationInSeconds),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador de animação
    super.dispose();
  }

  void startTimer() {
    setState(() {
      isRunning = true;
      _controller.duration = Duration(seconds: durationInSeconds);
      _controller.forward();
    });

    Timer(Duration(seconds: durationInSeconds), () {
      setState(() {
        isRunning = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Iniciar produção',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            SizedBox(height: 10),
            Text(
              'Defina o tempo (em segundos):',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Campo de entrada para o tempo
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tempo em segundos',
              ),
              onChanged: (value) {
                setState(() {
                  durationInSeconds = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startTimer, // Desabilita o botão enquanto o timer está rodando
              child: Text(isRunning ? 'Em execução...' : 'Iniciar'),
            ),
            SizedBox(height: 20),
            // Exibe a animação do temporizador
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.green,
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      (durationInSeconds * _animation.value).toStringAsFixed(0),
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                );
              },
            ),
            Spacer(),
            // Botões Salvar e Excluir
          ],
        ),
      ),
    );
  }
}
