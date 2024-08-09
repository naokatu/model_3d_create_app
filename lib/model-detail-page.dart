import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ModelDetailPage extends StatefulWidget {
  final String filename;
  const ModelDetailPage({super.key, required this.filename});

  @override
  State<ModelDetailPage> createState() => _ModelDetailPage();
}

class _ModelDetailPage extends State<ModelDetailPage> {
  String? filePath;
  @override
  void initState() {
    super.initState();
    _loadModelPath();
  }
  Future<void> _loadModelPath() async {
    final directory = await getApplicationDocumentsDirectory(); // 内部ストレージのパスを取得
    setState(() {
      filePath = '${directory.path}/${widget.filename}.glb';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: filePath == null
            ? CircularProgressIndicator() // ファイルパスの読み込み中はローディングを表示
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                  '${widget.filename}から遷移されました',
                  ),
                  Expanded(
                    child: ModelViewer(
                      src: 'file://$filePath',
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
