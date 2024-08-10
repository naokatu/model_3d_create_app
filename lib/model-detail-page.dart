import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';

class ModelDetailPage extends StatefulWidget {
  final String url;

  const ModelDetailPage({super.key, required this.url});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPage();
}

class _ModelDetailPage extends State<ModelDetailPage> {
  String? _modelPath;

  @override
  void initState() {
    super.initState();
    _initializeModelPath();
  }

  Future<void> _initializeModelPath() async {
    final directory = await getApplicationDocumentsDirectory();
    setState(() {
      _modelPath = '${directory.path}/${widget.url}';
    });
  }

  void _navigateQR() async {
    Navigator.of(context).pushNamed('/qr-create-page', arguments: widget.url);
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
                '${widget.url}です',
              ),
              Expanded(
                child: ModelViewer(
                  src: '$_modelPath',
                  iosSrc: '$_modelPath',
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
                onPressed: _navigateQR,
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
