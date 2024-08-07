import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelDetailPage extends StatefulWidget {
  final String content;
  const ModelDetailPage({super.key, required this.content});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPage();
}

class _ModelDetailPage extends State<ModelDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
           '${widget.content}から遷移されました',
          ),
          Expanded(
            child: ModelViewer(
              src: 'assets/${widget.content}.glb',
              iosSrc: 'assets/${widget.content}.usdz',
              ar: true,
              autoRotate: true,
              cameraControls: true,
            ),
          ),
        ],
      ),
    );
  }
}
