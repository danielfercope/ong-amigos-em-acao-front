import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String barcode = "Nenhum código escaneado";

  Future<void> scanBarcode() async {
    try {
      String scannedCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', // Cor do botão "Cancelar"
        'Cancelar', // Texto do botão
        true, // Mostra o modo de leitura (luz/flash)
        ScanMode.BARCODE, // Tipo de escaneamento
      );

      if (scannedCode != '-1') {
        setState(() {
          barcode = scannedCode;
        });
      }
    } catch (e) {
      setState(() {
        barcode = 'Erro ao escanear código';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leitura de Código de Barras')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              barcode,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: scanBarcode,
              child: Text('Escanear Código'),
            ),
          ],
        ),
      ),
    );
  }
}
