import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreatePage extends StatefulWidget {
  final String filename;
  const QrCreatePage({super.key, required this.filename});

  @override
  State<QrCreatePage> createState() => _QrCreatePageState();
}

class _QrCreatePageState extends State<QrCreatePage> {
  Future<String> getModelUrl() async {
    // TODO: モデルのURLをここで作成

    await Future.delayed(Duration(seconds: 2)); // シミュレーションのための遅延
    return 'https://google.com/';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getModelUrl(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return Center(
              child: Container(
                color: Colors.white,
                child: QrImageView(
                  data: snapshot.data!,
                  version: QrVersions.auto,
                  size: 250.0,
                  backgroundColor: Colors.white,
                ),
              )
          );
        } else {
          return const Center(child: Text('No data'));
        }
      },
    );
  }
}