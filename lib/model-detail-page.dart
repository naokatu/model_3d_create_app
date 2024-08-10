import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelDetailPage extends StatelessWidget {
  final String url;

  const ModelDetailPage({super.key, required this.url});

  void _navigateQR(BuildContext context) {
    Navigator.of(context).pushNamed('/qr-create-page', arguments: url);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$urlです',
              ),
              Expanded(
                child: ModelViewer(
                  src: url,
                  iosSrc: url,
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          bottom: 64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => _navigateQR(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18)),
                child: const Text('QRコードを作成する'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}