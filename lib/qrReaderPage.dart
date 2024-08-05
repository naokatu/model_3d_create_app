import 'package:flutter/material.dart';

class QrReaderPage extends StatefulWidget {
  const QrReaderPage({super.key});

  @override
  State<QrReaderPage> createState() => _QrReaderPage();
}

class _QrReaderPage extends State<QrReaderPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('ここはQRで3Dモデルを確認するページです')
        ],
      ),
    );
  }
}
