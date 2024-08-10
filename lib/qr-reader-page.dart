import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReaderPage extends StatefulWidget {
  const QrReaderPage({super.key});

  @override
  State<QrReaderPage> createState() => _QrReaderPageState();
}

class _QrReaderPageState extends State<QrReaderPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) {
        controller.scannedDataStream.listen((scanData) {
          if (scanData.code != null) {
            Navigator.of(context).pushNamed('/model-detail',
                arguments: {'title': scanData.code!});
            controller.dispose();
          }
        });
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}