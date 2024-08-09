import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import './select-button.dart';

class ListModelPage extends StatefulWidget {
  const ListModelPage({super.key});

  @override
  State<ListModelPage> createState() => _ListModelPage();
}

class _ListModelPage extends State<ListModelPage> {
  List<String> _models = [];
  @override
  void initState() {
    super.initState();
    _loadModels();
  }

  void _loadModels() async {
    final directory = await getApplicationDocumentsDirectory();
    final modelsDir = Directory(directory.path);
    final files = modelsDir.listSync(); // ディレクトリ内のファイルリストを取得

    setState(() {
      _models = files
          .where((file) => file.path.endsWith('.glb')) // .glbファイルのみを対象
          .map((file) => file.uri.pathSegments.last.replaceAll('.glb', '')) // ファイル名だけを取り出してリストに追加
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _models.length,
      itemBuilder: (context, index) {
        return SelectButton(
            buttonText: _models[index],
            iconPath: null, // 画像はなし
            nextPage: '/model-detail', 
          );
      },
      
    );
  }
}
