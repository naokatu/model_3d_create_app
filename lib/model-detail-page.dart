import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';

class ModelDetailPage extends StatefulWidget {
  final String title;

  const ModelDetailPage({super.key, required this.title});

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
      _modelPath = '${directory.path}/${widget.title}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${widget.title}です',
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
    );
  }
}
