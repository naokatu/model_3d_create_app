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

  Future<void> _loadModels() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final dir = Directory(directory.path);
      List<FileSystemEntity> files = await dir.list().toList();
      List<String> jpgFiles = files
          .whereType<File>()
          .where((file) => file.path.toLowerCase().endsWith('.jpg'))
          .map((file) => file.path.split('/').last)
          .toList();

      setState(() {
        _models = jpgFiles;
      });
    } catch (e) {
      print('Error loading models: $e');
      // エラーが発生した場合の処理をここに追加
    }
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
