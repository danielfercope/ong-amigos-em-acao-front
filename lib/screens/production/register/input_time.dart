import 'package:flutter/material.dart';

import '../../util/OrderClass.dart';

class InputTime extends StatefulWidget {
  final OrderClass order;

  InputTime({required this.order});

  @override
  _InputTimeState createState() => _InputTimeState();
}

class _InputTimeState extends State<InputTime> with SingleTickerProviderStateMixin {
  int durationInMinutes = 0; // Duração do temporizador em minutos
  bool isRunning = false; // Indica se o temporizador está em execução
  late AnimationController _controller; // Controlador de animação

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: durationInMinutes),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Libera o controlador de animação
    super.dispose();
  }

  void startTimer() {
    setState(() {
      isRunning = true;
      _controller.duration = Duration(minutes: durationInMinutes);
      _controller.reverse(from: 1.0); // Inicia a animação do fim para o começo
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isRunning = false;
        });
      }
    });
  }

  String formatDuration(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}min ${seconds.toString().padLeft(2, '0')}seg';
  }

  void incrementDuration() {
    setState(() {
      durationInMinutes++;
    });
  }

  void decrementDuration() {
    setState(() {
      if (durationInMinutes > 0) {
        durationInMinutes--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Center(
              child: Image.asset(
                widget.order.imageUrl,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tempo: ${formatDuration(durationInMinutes * 60)}', // Converte minutos para segundos para exibir
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decrementDuration,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: incrementDuration,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? null : startTimer,
              child: Text(isRunning ? 'Em execução...' : 'Iniciar'),
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            value: _controller.value,
                            strokeWidth: 8.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formatDuration((durationInMinutes * 60 * _controller.value).toInt()), // Converte para segundos
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${(_controller.value * 100).toStringAsFixed(0)}%',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
